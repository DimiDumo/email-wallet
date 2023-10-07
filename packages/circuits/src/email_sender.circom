
pragma circom 2.1.5;

include "circomlib/circuits/bitify.circom";
include "circomlib/circuits/comparators.circom";
include "circomlib/circuits/poseidon.circom";
include "@zk-email/circuits/email-verifier.circom";
include "@zk-email/circuits/helpers/extract.circom";
include "./utils/constants.circom";
include "./utils/email_addr_pointer.circom";
include "./utils/email_addr_commit.circom";
include "./utils/hash_sign.circom";
include "./utils/email_nullifier.circom";
include "./utils/bytes2ints.circom";
include "./utils/digit2int.circom";
include "@zk-email/zk-regex-circom/circuits/common/from_addr_regex.circom";
include "@zk-email/zk-regex-circom/circuits/common/email_addr_regex.circom";
include "@zk-email/zk-regex-circom/circuits/common/email_domain_regex.circom";
include "@zk-email/zk-regex-circom/circuits/common/subject_all_regex.circom";
include "@zk-email/zk-regex-circom/circuits/common/timestamp_regex.circom";

// Here, n and k are the biginteger parameters for RSA
// This is because the number is chunked into k pack_size of n bits each
template EmailSender(n, k, max_header_bytes, max_subject_bytes) {
    signal input in_padded[max_header_bytes]; // prehashed email data, includes up to 512 + 64? bytes of padding pre SHA256, and padded with lots of 0s at end after the length
    signal input pubkey[k]; // rsa pubkey, verified with smart contract + DNSSEC proof. split up into k parts of n bits each.
    signal input signature[k]; // rsa signature. split up into k parts of n bits each.
    signal input in_padded_len; // length of in email data including the padding, which will inform the sha256 block length
    signal input sender_relayer_rand;
    signal input sender_email_idx; // index of the from email address (= sender email address) in the header
    signal input subject_idx; // index of the subject in the header
    signal input recipient_email_idx; // index of the recipient email address in the subject
    signal input domain_idx;
    signal input timestamp_idx;

    var email_max_bytes = email_max_bytes_const();
    var domain_len = domain_len_const();
    var k2_chunked_size = k >> 1;
    if(k % 2 == 1) {
        k2_chunked_size += 1;
    }
    var timestamp_len = timestamp_len_const();

    signal output masked_subject_str[max_subject_bytes];
    signal output domain_name[domain_len];
    signal output pubkey_hash;
    signal output sender_relayer_rand_hash;
    signal output email_nullifier;
    signal output sender_pointer;
    signal output has_email_recipient;
    signal output recipient_email_addr_commit;
    signal output timestamp;
    
    
    component email_verifier = EmailVerifier(max_header_bytes, 0, n, k, 1);
    email_verifier.in_padded <== in_padded;
    email_verifier.pubkey <== pubkey;
    email_verifier.signature <== signature;
    email_verifier.in_len_padded_bytes <== in_padded_len;
    signal header_hash[256] <== email_verifier.sha;
    pubkey_hash <== email_verifier.pubkey_hash;

    // FROM HEADER REGEX
    signal from_regex_out, from_regex_reveal[max_header_bytes];
    (from_regex_out, from_regex_reveal) <== FromAddrRegex(max_header_bytes)(in_padded);
    from_regex_out === 1;
    signal sender_email_addr[email_max_bytes];
    sender_email_addr <== VarShiftLeft(max_header_bytes, email_max_bytes)(from_regex_reveal, sender_email_idx);

    // SUBJECT HEADER REGEX
    signal subject_regex_out, subject_regex_reveal[max_header_bytes];
    (subject_regex_out, subject_regex_reveal) <== SubjectAllRegex(max_header_bytes)(in_padded);
    subject_regex_out === 1;
    signal subject_all[max_subject_bytes];
    subject_all <== VarShiftLeft(max_header_bytes, max_subject_bytes)(subject_regex_reveal, subject_idx);
    signal recipient_email_regex_out, recipient_email_regex_reveal[max_subject_bytes];
    (recipient_email_regex_out, recipient_email_regex_reveal) <== EmailAddrRegex(max_subject_bytes)(subject_all);
    has_email_recipient <== IsZero()(recipient_email_regex_out-1);
    signal recipient_email_addr[email_max_bytes];
    recipient_email_addr <== VarShiftLeft(max_subject_bytes, email_max_bytes)(recipient_email_regex_reveal, recipient_email_idx);
    for(var i = 0; i < max_subject_bytes; i++) {
        masked_subject_str[i] <== subject_all[i] - has_email_recipient * recipient_email_regex_reveal[i];
    }

    // DOMAIN NAME HEADER REGEX
    signal domain_regex_out, domain_regex_reveal[email_max_bytes];
    (domain_regex_out, domain_regex_reveal) <== EmailDomainRegex(email_max_bytes)(sender_email_addr);
    domain_regex_out === 1;
    domain_name <== VarShiftLeft(email_max_bytes, domain_len)(domain_regex_reveal, domain_idx);
    
    signal sign_hash;
    signal sign_ints[k2_chunked_size];
    (sign_hash, sign_ints) <== HashSign(n,k)(signature);
    sender_relayer_rand_hash <== Poseidon(1)([sender_relayer_rand]);

    email_nullifier <== EmailNullifier()(sign_hash);

    var num_email_addr_ints = compute_ints_size(email_max_bytes);
    signal sender_email_addr_ints[num_email_addr_ints] <== Bytes2Ints(email_max_bytes)(sender_email_addr);
    sender_pointer <== EmailAddrPointer(num_email_addr_ints)(sender_relayer_rand, sender_email_addr_ints);
    // signal sender_vk_wtns_input[2];
    // sender_vk_wtns_input[0] <== cm_rand;
    // sender_vk_wtns_input[1] <== sender_vk;
    // sender_vk_wtns <== Poseidon(2)(sender_vk_wtns_input);
    signal cm_rand_input[k2_chunked_size+1];
    for(var i=0; i<k2_chunked_size;i++){
        cm_rand_input[i] <== sign_ints[i];
    }
    cm_rand_input[k2_chunked_size] <== 1;
    signal cm_rand <== Poseidon(k2_chunked_size+1)(cm_rand_input);
    signal recipient_email_addr_ints[num_email_addr_ints] <== Bytes2Ints(email_max_bytes)(recipient_email_addr);
    recipient_email_addr_commit <== EmailAddrCommit(num_email_addr_ints)(cm_rand, recipient_email_addr_ints);

    // TIMESTAMP REGEX
    signal timestamp_regex_out, timestamp_regex_reveal[max_header_bytes];
    (timestamp_regex_out, timestamp_regex_reveal) <== TimestampRegex(max_header_bytes)(in_padded);
    timestamp_regex_out === 1;
    signal timestamp_str[timestamp_len];
    timestamp_str <== VarShiftLeft(max_header_bytes, timestamp_len)(timestamp_regex_reveal, timestamp_idx);
    timestamp <== Digit2Int(timestamp_len)(timestamp_str);
}

// Args:
// * n = 121 is the number of bits in each chunk of the modulus (RSA parameter)
// * k = 17 is the number of chunks in the modulus (RSA parameter)
// * max_header_bytes = 1024 is the max number of bytes in the header
// * max_subject_bytes = 512 is the max number of bytes in the body after precomputed slice
component main  = EmailSender(121, 17, 1024, 512);
