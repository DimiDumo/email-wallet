pragma circom 2.1.5;
include "@zk-email/circuits/regexes/regex_helpers.circom";

template EmailAddrRegex(msg_bytes) {
	signal input msg[msg_bytes];
	signal output out;

	var num_bytes = msg_bytes+1;
	signal in[num_bytes];
	in[0]<==128;
	for (var i = 0; i < msg_bytes; i++) {
		in[i+1] <== msg[i];
	}

	component eq[78][num_bytes];
	component lt[54][num_bytes];
	component and[39][num_bytes];
	component multi_or[15][num_bytes];
	signal states[num_bytes+1][4];

	for (var i = 0; i < num_bytes; i++) {
		states[i][0] <== 1;
	}
	for (var i = 1; i < 4; i++) {
		states[0][i] <== 0;
	}

	for (var i = 0; i < num_bytes; i++) {
		lt[0][i] = LessThan(8);
		lt[0][i].in[0] <== 47;
		lt[0][i].in[1] <== in[i];
		lt[1][i] = LessThan(8);
		lt[1][i].in[0] <== in[i];
		lt[1][i].in[1] <== 58;
		and[0][i] = AND();
		and[0][i].a <== lt[0][i].out;
		and[0][i].b <== lt[1][i].out;
		lt[2][i] = LessThan(8);
		lt[2][i].in[0] <== 64;
		lt[2][i].in[1] <== in[i];
		lt[3][i] = LessThan(8);
		lt[3][i].in[0] <== in[i];
		lt[3][i].in[1] <== 91;
		and[1][i] = AND();
		and[1][i].a <== lt[2][i].out;
		and[1][i].b <== lt[3][i].out;
		lt[4][i] = LessThan(8);
		lt[4][i].in[0] <== 96;
		lt[4][i].in[1] <== in[i];
		lt[5][i] = LessThan(8);
		lt[5][i].in[0] <== in[i];
		lt[5][i].in[1] <== 123;
		and[2][i] = AND();
		and[2][i].a <== lt[4][i].out;
		and[2][i].b <== lt[5][i].out;
		eq[0][i] = IsEqual();
		eq[0][i].in[0] <== in[i];
		eq[0][i].in[1] <== 91;
		eq[1][i] = IsEqual();
		eq[1][i].in[0] <== in[i];
		eq[1][i].in[1] <== 34;
		eq[2][i] = IsEqual();
		eq[2][i].in[0] <== in[i];
		eq[2][i].in[1] <== 37;
		eq[3][i] = IsEqual();
		eq[3][i].in[0] <== in[i];
		eq[3][i].in[1] <== 44;
		eq[4][i] = IsEqual();
		eq[4][i].in[0] <== in[i];
		eq[4][i].in[1] <== 43;
		eq[5][i] = IsEqual();
		eq[5][i].in[0] <== in[i];
		eq[5][i].in[1] <== 45;
		eq[6][i] = IsEqual();
		eq[6][i].in[0] <== in[i];
		eq[6][i].in[1] <== 46;
		eq[7][i] = IsEqual();
		eq[7][i].in[0] <== in[i];
		eq[7][i].in[1] <== 61;
		eq[8][i] = IsEqual();
		eq[8][i].in[0] <== in[i];
		eq[8][i].in[1] <== 95;
		eq[9][i] = IsEqual();
		eq[9][i].in[0] <== in[i];
		eq[9][i].in[1] <== 93;
		and[3][i] = AND();
		and[3][i].a <== states[i][0];
		multi_or[0][i] = MultiOR(13);
		multi_or[0][i].in[0] <== and[0][i].out;
		multi_or[0][i].in[1] <== and[1][i].out;
		multi_or[0][i].in[2] <== and[2][i].out;
		multi_or[0][i].in[3] <== eq[0][i].out;
		multi_or[0][i].in[4] <== eq[1][i].out;
		multi_or[0][i].in[5] <== eq[2][i].out;
		multi_or[0][i].in[6] <== eq[3][i].out;
		multi_or[0][i].in[7] <== eq[4][i].out;
		multi_or[0][i].in[8] <== eq[5][i].out;
		multi_or[0][i].in[9] <== eq[6][i].out;
		multi_or[0][i].in[10] <== eq[7][i].out;
		multi_or[0][i].in[11] <== eq[8][i].out;
		multi_or[0][i].in[12] <== eq[9][i].out;
		and[3][i].b <== multi_or[0][i].out;
		eq[10][i] = IsEqual();
		eq[10][i].in[0] <== in[i];
		eq[10][i].in[1] <== 91;
		eq[11][i] = IsEqual();
		eq[11][i].in[0] <== in[i];
		eq[11][i].in[1] <== 34;
		eq[12][i] = IsEqual();
		eq[12][i].in[0] <== in[i];
		eq[12][i].in[1] <== 64;
		eq[13][i] = IsEqual();
		eq[13][i].in[0] <== in[i];
		eq[13][i].in[1] <== 93;
		and[4][i] = AND();
		and[4][i].a <== states[i][1];
		multi_or[1][i] = MultiOR(4);
		multi_or[1][i].in[0] <== eq[10][i].out;
		multi_or[1][i].in[1] <== eq[11][i].out;
		multi_or[1][i].in[2] <== eq[12][i].out;
		multi_or[1][i].in[3] <== eq[13][i].out;
		and[4][i].b <== multi_or[1][i].out;
		lt[6][i] = LessThan(8);
		lt[6][i].in[0] <== 47;
		lt[6][i].in[1] <== in[i];
		lt[7][i] = LessThan(8);
		lt[7][i].in[0] <== in[i];
		lt[7][i].in[1] <== 58;
		and[5][i] = AND();
		and[5][i].a <== lt[6][i].out;
		and[5][i].b <== lt[7][i].out;
		lt[8][i] = LessThan(8);
		lt[8][i].in[0] <== 64;
		lt[8][i].in[1] <== in[i];
		lt[9][i] = LessThan(8);
		lt[9][i].in[0] <== in[i];
		lt[9][i].in[1] <== 91;
		and[6][i] = AND();
		and[6][i].a <== lt[8][i].out;
		and[6][i].b <== lt[9][i].out;
		lt[10][i] = LessThan(8);
		lt[10][i].in[0] <== 96;
		lt[10][i].in[1] <== in[i];
		lt[11][i] = LessThan(8);
		lt[11][i].in[0] <== in[i];
		lt[11][i].in[1] <== 123;
		and[7][i] = AND();
		and[7][i].a <== lt[10][i].out;
		and[7][i].b <== lt[11][i].out;
		eq[14][i] = IsEqual();
		eq[14][i].in[0] <== in[i];
		eq[14][i].in[1] <== 91;
		eq[15][i] = IsEqual();
		eq[15][i].in[0] <== in[i];
		eq[15][i].in[1] <== 34;
		eq[16][i] = IsEqual();
		eq[16][i].in[0] <== in[i];
		eq[16][i].in[1] <== 45;
		eq[17][i] = IsEqual();
		eq[17][i].in[0] <== in[i];
		eq[17][i].in[1] <== 44;
		eq[18][i] = IsEqual();
		eq[18][i].in[0] <== in[i];
		eq[18][i].in[1] <== 46;
		eq[19][i] = IsEqual();
		eq[19][i].in[0] <== in[i];
		eq[19][i].in[1] <== 93;
		and[8][i] = AND();
		and[8][i].a <== states[i][2];
		multi_or[2][i] = MultiOR(9);
		multi_or[2][i].in[0] <== and[5][i].out;
		multi_or[2][i].in[1] <== and[6][i].out;
		multi_or[2][i].in[2] <== and[7][i].out;
		multi_or[2][i].in[3] <== eq[14][i].out;
		multi_or[2][i].in[4] <== eq[15][i].out;
		multi_or[2][i].in[5] <== eq[16][i].out;
		multi_or[2][i].in[6] <== eq[17][i].out;
		multi_or[2][i].in[7] <== eq[18][i].out;
		multi_or[2][i].in[8] <== eq[19][i].out;
		and[8][i].b <== multi_or[2][i].out;
		lt[12][i] = LessThan(8);
		lt[12][i].in[0] <== 47;
		lt[12][i].in[1] <== in[i];
		lt[13][i] = LessThan(8);
		lt[13][i].in[0] <== in[i];
		lt[13][i].in[1] <== 58;
		and[9][i] = AND();
		and[9][i].a <== lt[12][i].out;
		and[9][i].b <== lt[13][i].out;
		lt[14][i] = LessThan(8);
		lt[14][i].in[0] <== 64;
		lt[14][i].in[1] <== in[i];
		lt[15][i] = LessThan(8);
		lt[15][i].in[0] <== in[i];
		lt[15][i].in[1] <== 91;
		and[10][i] = AND();
		and[10][i].a <== lt[14][i].out;
		and[10][i].b <== lt[15][i].out;
		lt[16][i] = LessThan(8);
		lt[16][i].in[0] <== 96;
		lt[16][i].in[1] <== in[i];
		lt[17][i] = LessThan(8);
		lt[17][i].in[0] <== in[i];
		lt[17][i].in[1] <== 123;
		and[11][i] = AND();
		and[11][i].a <== lt[16][i].out;
		and[11][i].b <== lt[17][i].out;
		eq[20][i] = IsEqual();
		eq[20][i].in[0] <== in[i];
		eq[20][i].in[1] <== 91;
		eq[21][i] = IsEqual();
		eq[21][i].in[0] <== in[i];
		eq[21][i].in[1] <== 34;
		eq[22][i] = IsEqual();
		eq[22][i].in[0] <== in[i];
		eq[22][i].in[1] <== 45;
		eq[23][i] = IsEqual();
		eq[23][i].in[0] <== in[i];
		eq[23][i].in[1] <== 44;
		eq[24][i] = IsEqual();
		eq[24][i].in[0] <== in[i];
		eq[24][i].in[1] <== 46;
		eq[25][i] = IsEqual();
		eq[25][i].in[0] <== in[i];
		eq[25][i].in[1] <== 93;
		and[12][i] = AND();
		and[12][i].a <== states[i][3];
		multi_or[3][i] = MultiOR(9);
		multi_or[3][i].in[0] <== and[9][i].out;
		multi_or[3][i].in[1] <== and[10][i].out;
		multi_or[3][i].in[2] <== and[11][i].out;
		multi_or[3][i].in[3] <== eq[20][i].out;
		multi_or[3][i].in[4] <== eq[21][i].out;
		multi_or[3][i].in[5] <== eq[22][i].out;
		multi_or[3][i].in[6] <== eq[23][i].out;
		multi_or[3][i].in[7] <== eq[24][i].out;
		multi_or[3][i].in[8] <== eq[25][i].out;
		and[12][i].b <== multi_or[3][i].out;
		multi_or[4][i] = MultiOR(4);
		multi_or[4][i].in[0] <== and[3][i].out;
		multi_or[4][i].in[1] <== and[4][i].out;
		multi_or[4][i].in[2] <== and[8][i].out;
		multi_or[4][i].in[3] <== and[12][i].out;
		states[i+1][1] <== multi_or[4][i].out;
		lt[18][i] = LessThan(8);
		lt[18][i].in[0] <== 47;
		lt[18][i].in[1] <== in[i];
		lt[19][i] = LessThan(8);
		lt[19][i].in[0] <== in[i];
		lt[19][i].in[1] <== 58;
		and[13][i] = AND();
		and[13][i].a <== lt[18][i].out;
		and[13][i].b <== lt[19][i].out;
		lt[20][i] = LessThan(8);
		lt[20][i].in[0] <== 64;
		lt[20][i].in[1] <== in[i];
		lt[21][i] = LessThan(8);
		lt[21][i].in[0] <== in[i];
		lt[21][i].in[1] <== 91;
		and[14][i] = AND();
		and[14][i].a <== lt[20][i].out;
		and[14][i].b <== lt[21][i].out;
		lt[22][i] = LessThan(8);
		lt[22][i].in[0] <== 96;
		lt[22][i].in[1] <== in[i];
		lt[23][i] = LessThan(8);
		lt[23][i].in[0] <== in[i];
		lt[23][i].in[1] <== 123;
		and[15][i] = AND();
		and[15][i].a <== lt[22][i].out;
		and[15][i].b <== lt[23][i].out;
		eq[26][i] = IsEqual();
		eq[26][i].in[0] <== in[i];
		eq[26][i].in[1] <== 91;
		eq[27][i] = IsEqual();
		eq[27][i].in[0] <== in[i];
		eq[27][i].in[1] <== 34;
		eq[28][i] = IsEqual();
		eq[28][i].in[0] <== in[i];
		eq[28][i].in[1] <== 37;
		eq[29][i] = IsEqual();
		eq[29][i].in[0] <== in[i];
		eq[29][i].in[1] <== 44;
		eq[30][i] = IsEqual();
		eq[30][i].in[0] <== in[i];
		eq[30][i].in[1] <== 43;
		eq[31][i] = IsEqual();
		eq[31][i].in[0] <== in[i];
		eq[31][i].in[1] <== 45;
		eq[32][i] = IsEqual();
		eq[32][i].in[0] <== in[i];
		eq[32][i].in[1] <== 46;
		eq[33][i] = IsEqual();
		eq[33][i].in[0] <== in[i];
		eq[33][i].in[1] <== 61;
		eq[34][i] = IsEqual();
		eq[34][i].in[0] <== in[i];
		eq[34][i].in[1] <== 95;
		eq[35][i] = IsEqual();
		eq[35][i].in[0] <== in[i];
		eq[35][i].in[1] <== 93;
		and[16][i] = AND();
		and[16][i].a <== states[i][0];
		multi_or[5][i] = MultiOR(13);
		multi_or[5][i].in[0] <== and[13][i].out;
		multi_or[5][i].in[1] <== and[14][i].out;
		multi_or[5][i].in[2] <== and[15][i].out;
		multi_or[5][i].in[3] <== eq[26][i].out;
		multi_or[5][i].in[4] <== eq[27][i].out;
		multi_or[5][i].in[5] <== eq[28][i].out;
		multi_or[5][i].in[6] <== eq[29][i].out;
		multi_or[5][i].in[7] <== eq[30][i].out;
		multi_or[5][i].in[8] <== eq[31][i].out;
		multi_or[5][i].in[9] <== eq[32][i].out;
		multi_or[5][i].in[10] <== eq[33][i].out;
		multi_or[5][i].in[11] <== eq[34][i].out;
		multi_or[5][i].in[12] <== eq[35][i].out;
		and[16][i].b <== multi_or[5][i].out;
		eq[36][i] = IsEqual();
		eq[36][i].in[0] <== in[i];
		eq[36][i].in[1] <== 91;
		eq[37][i] = IsEqual();
		eq[37][i].in[0] <== in[i];
		eq[37][i].in[1] <== 34;
		eq[38][i] = IsEqual();
		eq[38][i].in[0] <== in[i];
		eq[38][i].in[1] <== 64;
		eq[39][i] = IsEqual();
		eq[39][i].in[0] <== in[i];
		eq[39][i].in[1] <== 93;
		and[17][i] = AND();
		and[17][i].a <== states[i][1];
		multi_or[6][i] = MultiOR(4);
		multi_or[6][i].in[0] <== eq[36][i].out;
		multi_or[6][i].in[1] <== eq[37][i].out;
		multi_or[6][i].in[2] <== eq[38][i].out;
		multi_or[6][i].in[3] <== eq[39][i].out;
		and[17][i].b <== multi_or[6][i].out;
		lt[24][i] = LessThan(8);
		lt[24][i].in[0] <== 47;
		lt[24][i].in[1] <== in[i];
		lt[25][i] = LessThan(8);
		lt[25][i].in[0] <== in[i];
		lt[25][i].in[1] <== 58;
		and[18][i] = AND();
		and[18][i].a <== lt[24][i].out;
		and[18][i].b <== lt[25][i].out;
		lt[26][i] = LessThan(8);
		lt[26][i].in[0] <== 64;
		lt[26][i].in[1] <== in[i];
		lt[27][i] = LessThan(8);
		lt[27][i].in[0] <== in[i];
		lt[27][i].in[1] <== 91;
		and[19][i] = AND();
		and[19][i].a <== lt[26][i].out;
		and[19][i].b <== lt[27][i].out;
		lt[28][i] = LessThan(8);
		lt[28][i].in[0] <== 96;
		lt[28][i].in[1] <== in[i];
		lt[29][i] = LessThan(8);
		lt[29][i].in[0] <== in[i];
		lt[29][i].in[1] <== 123;
		and[20][i] = AND();
		and[20][i].a <== lt[28][i].out;
		and[20][i].b <== lt[29][i].out;
		eq[40][i] = IsEqual();
		eq[40][i].in[0] <== in[i];
		eq[40][i].in[1] <== 91;
		eq[41][i] = IsEqual();
		eq[41][i].in[0] <== in[i];
		eq[41][i].in[1] <== 34;
		eq[42][i] = IsEqual();
		eq[42][i].in[0] <== in[i];
		eq[42][i].in[1] <== 45;
		eq[43][i] = IsEqual();
		eq[43][i].in[0] <== in[i];
		eq[43][i].in[1] <== 44;
		eq[44][i] = IsEqual();
		eq[44][i].in[0] <== in[i];
		eq[44][i].in[1] <== 46;
		eq[45][i] = IsEqual();
		eq[45][i].in[0] <== in[i];
		eq[45][i].in[1] <== 93;
		and[21][i] = AND();
		and[21][i].a <== states[i][2];
		multi_or[7][i] = MultiOR(9);
		multi_or[7][i].in[0] <== and[18][i].out;
		multi_or[7][i].in[1] <== and[19][i].out;
		multi_or[7][i].in[2] <== and[20][i].out;
		multi_or[7][i].in[3] <== eq[40][i].out;
		multi_or[7][i].in[4] <== eq[41][i].out;
		multi_or[7][i].in[5] <== eq[42][i].out;
		multi_or[7][i].in[6] <== eq[43][i].out;
		multi_or[7][i].in[7] <== eq[44][i].out;
		multi_or[7][i].in[8] <== eq[45][i].out;
		and[21][i].b <== multi_or[7][i].out;
		lt[30][i] = LessThan(8);
		lt[30][i].in[0] <== 47;
		lt[30][i].in[1] <== in[i];
		lt[31][i] = LessThan(8);
		lt[31][i].in[0] <== in[i];
		lt[31][i].in[1] <== 58;
		and[22][i] = AND();
		and[22][i].a <== lt[30][i].out;
		and[22][i].b <== lt[31][i].out;
		lt[32][i] = LessThan(8);
		lt[32][i].in[0] <== 64;
		lt[32][i].in[1] <== in[i];
		lt[33][i] = LessThan(8);
		lt[33][i].in[0] <== in[i];
		lt[33][i].in[1] <== 91;
		and[23][i] = AND();
		and[23][i].a <== lt[32][i].out;
		and[23][i].b <== lt[33][i].out;
		lt[34][i] = LessThan(8);
		lt[34][i].in[0] <== 96;
		lt[34][i].in[1] <== in[i];
		lt[35][i] = LessThan(8);
		lt[35][i].in[0] <== in[i];
		lt[35][i].in[1] <== 123;
		and[24][i] = AND();
		and[24][i].a <== lt[34][i].out;
		and[24][i].b <== lt[35][i].out;
		eq[46][i] = IsEqual();
		eq[46][i].in[0] <== in[i];
		eq[46][i].in[1] <== 91;
		eq[47][i] = IsEqual();
		eq[47][i].in[0] <== in[i];
		eq[47][i].in[1] <== 34;
		eq[48][i] = IsEqual();
		eq[48][i].in[0] <== in[i];
		eq[48][i].in[1] <== 45;
		eq[49][i] = IsEqual();
		eq[49][i].in[0] <== in[i];
		eq[49][i].in[1] <== 44;
		eq[50][i] = IsEqual();
		eq[50][i].in[0] <== in[i];
		eq[50][i].in[1] <== 46;
		eq[51][i] = IsEqual();
		eq[51][i].in[0] <== in[i];
		eq[51][i].in[1] <== 93;
		and[25][i] = AND();
		and[25][i].a <== states[i][3];
		multi_or[8][i] = MultiOR(9);
		multi_or[8][i].in[0] <== and[22][i].out;
		multi_or[8][i].in[1] <== and[23][i].out;
		multi_or[8][i].in[2] <== and[24][i].out;
		multi_or[8][i].in[3] <== eq[46][i].out;
		multi_or[8][i].in[4] <== eq[47][i].out;
		multi_or[8][i].in[5] <== eq[48][i].out;
		multi_or[8][i].in[6] <== eq[49][i].out;
		multi_or[8][i].in[7] <== eq[50][i].out;
		multi_or[8][i].in[8] <== eq[51][i].out;
		and[25][i].b <== multi_or[8][i].out;
		multi_or[9][i] = MultiOR(4);
		multi_or[9][i].in[0] <== and[16][i].out;
		multi_or[9][i].in[1] <== and[17][i].out;
		multi_or[9][i].in[2] <== and[21][i].out;
		multi_or[9][i].in[3] <== and[25][i].out;
		states[i+1][2] <== multi_or[9][i].out;
		lt[36][i] = LessThan(8);
		lt[36][i].in[0] <== 47;
		lt[36][i].in[1] <== in[i];
		lt[37][i] = LessThan(8);
		lt[37][i].in[0] <== in[i];
		lt[37][i].in[1] <== 58;
		and[26][i] = AND();
		and[26][i].a <== lt[36][i].out;
		and[26][i].b <== lt[37][i].out;
		lt[38][i] = LessThan(8);
		lt[38][i].in[0] <== 64;
		lt[38][i].in[1] <== in[i];
		lt[39][i] = LessThan(8);
		lt[39][i].in[0] <== in[i];
		lt[39][i].in[1] <== 91;
		and[27][i] = AND();
		and[27][i].a <== lt[38][i].out;
		and[27][i].b <== lt[39][i].out;
		lt[40][i] = LessThan(8);
		lt[40][i].in[0] <== 96;
		lt[40][i].in[1] <== in[i];
		lt[41][i] = LessThan(8);
		lt[41][i].in[0] <== in[i];
		lt[41][i].in[1] <== 123;
		and[28][i] = AND();
		and[28][i].a <== lt[40][i].out;
		and[28][i].b <== lt[41][i].out;
		eq[52][i] = IsEqual();
		eq[52][i].in[0] <== in[i];
		eq[52][i].in[1] <== 91;
		eq[53][i] = IsEqual();
		eq[53][i].in[0] <== in[i];
		eq[53][i].in[1] <== 34;
		eq[54][i] = IsEqual();
		eq[54][i].in[0] <== in[i];
		eq[54][i].in[1] <== 37;
		eq[55][i] = IsEqual();
		eq[55][i].in[0] <== in[i];
		eq[55][i].in[1] <== 44;
		eq[56][i] = IsEqual();
		eq[56][i].in[0] <== in[i];
		eq[56][i].in[1] <== 43;
		eq[57][i] = IsEqual();
		eq[57][i].in[0] <== in[i];
		eq[57][i].in[1] <== 45;
		eq[58][i] = IsEqual();
		eq[58][i].in[0] <== in[i];
		eq[58][i].in[1] <== 46;
		eq[59][i] = IsEqual();
		eq[59][i].in[0] <== in[i];
		eq[59][i].in[1] <== 61;
		eq[60][i] = IsEqual();
		eq[60][i].in[0] <== in[i];
		eq[60][i].in[1] <== 95;
		eq[61][i] = IsEqual();
		eq[61][i].in[0] <== in[i];
		eq[61][i].in[1] <== 93;
		and[29][i] = AND();
		and[29][i].a <== states[i][0];
		multi_or[10][i] = MultiOR(13);
		multi_or[10][i].in[0] <== and[26][i].out;
		multi_or[10][i].in[1] <== and[27][i].out;
		multi_or[10][i].in[2] <== and[28][i].out;
		multi_or[10][i].in[3] <== eq[52][i].out;
		multi_or[10][i].in[4] <== eq[53][i].out;
		multi_or[10][i].in[5] <== eq[54][i].out;
		multi_or[10][i].in[6] <== eq[55][i].out;
		multi_or[10][i].in[7] <== eq[56][i].out;
		multi_or[10][i].in[8] <== eq[57][i].out;
		multi_or[10][i].in[9] <== eq[58][i].out;
		multi_or[10][i].in[10] <== eq[59][i].out;
		multi_or[10][i].in[11] <== eq[60][i].out;
		multi_or[10][i].in[12] <== eq[61][i].out;
		and[29][i].b <== multi_or[10][i].out;
		eq[62][i] = IsEqual();
		eq[62][i].in[0] <== in[i];
		eq[62][i].in[1] <== 91;
		eq[63][i] = IsEqual();
		eq[63][i].in[0] <== in[i];
		eq[63][i].in[1] <== 34;
		eq[64][i] = IsEqual();
		eq[64][i].in[0] <== in[i];
		eq[64][i].in[1] <== 64;
		eq[65][i] = IsEqual();
		eq[65][i].in[0] <== in[i];
		eq[65][i].in[1] <== 93;
		and[30][i] = AND();
		and[30][i].a <== states[i][1];
		multi_or[11][i] = MultiOR(4);
		multi_or[11][i].in[0] <== eq[62][i].out;
		multi_or[11][i].in[1] <== eq[63][i].out;
		multi_or[11][i].in[2] <== eq[64][i].out;
		multi_or[11][i].in[3] <== eq[65][i].out;
		and[30][i].b <== multi_or[11][i].out;
		lt[42][i] = LessThan(8);
		lt[42][i].in[0] <== 47;
		lt[42][i].in[1] <== in[i];
		lt[43][i] = LessThan(8);
		lt[43][i].in[0] <== in[i];
		lt[43][i].in[1] <== 58;
		and[31][i] = AND();
		and[31][i].a <== lt[42][i].out;
		and[31][i].b <== lt[43][i].out;
		lt[44][i] = LessThan(8);
		lt[44][i].in[0] <== 64;
		lt[44][i].in[1] <== in[i];
		lt[45][i] = LessThan(8);
		lt[45][i].in[0] <== in[i];
		lt[45][i].in[1] <== 91;
		and[32][i] = AND();
		and[32][i].a <== lt[44][i].out;
		and[32][i].b <== lt[45][i].out;
		lt[46][i] = LessThan(8);
		lt[46][i].in[0] <== 96;
		lt[46][i].in[1] <== in[i];
		lt[47][i] = LessThan(8);
		lt[47][i].in[0] <== in[i];
		lt[47][i].in[1] <== 123;
		and[33][i] = AND();
		and[33][i].a <== lt[46][i].out;
		and[33][i].b <== lt[47][i].out;
		eq[66][i] = IsEqual();
		eq[66][i].in[0] <== in[i];
		eq[66][i].in[1] <== 91;
		eq[67][i] = IsEqual();
		eq[67][i].in[0] <== in[i];
		eq[67][i].in[1] <== 34;
		eq[68][i] = IsEqual();
		eq[68][i].in[0] <== in[i];
		eq[68][i].in[1] <== 45;
		eq[69][i] = IsEqual();
		eq[69][i].in[0] <== in[i];
		eq[69][i].in[1] <== 44;
		eq[70][i] = IsEqual();
		eq[70][i].in[0] <== in[i];
		eq[70][i].in[1] <== 46;
		eq[71][i] = IsEqual();
		eq[71][i].in[0] <== in[i];
		eq[71][i].in[1] <== 93;
		and[34][i] = AND();
		and[34][i].a <== states[i][2];
		multi_or[12][i] = MultiOR(9);
		multi_or[12][i].in[0] <== and[31][i].out;
		multi_or[12][i].in[1] <== and[32][i].out;
		multi_or[12][i].in[2] <== and[33][i].out;
		multi_or[12][i].in[3] <== eq[66][i].out;
		multi_or[12][i].in[4] <== eq[67][i].out;
		multi_or[12][i].in[5] <== eq[68][i].out;
		multi_or[12][i].in[6] <== eq[69][i].out;
		multi_or[12][i].in[7] <== eq[70][i].out;
		multi_or[12][i].in[8] <== eq[71][i].out;
		and[34][i].b <== multi_or[12][i].out;
		lt[48][i] = LessThan(8);
		lt[48][i].in[0] <== 47;
		lt[48][i].in[1] <== in[i];
		lt[49][i] = LessThan(8);
		lt[49][i].in[0] <== in[i];
		lt[49][i].in[1] <== 58;
		and[35][i] = AND();
		and[35][i].a <== lt[48][i].out;
		and[35][i].b <== lt[49][i].out;
		lt[50][i] = LessThan(8);
		lt[50][i].in[0] <== 64;
		lt[50][i].in[1] <== in[i];
		lt[51][i] = LessThan(8);
		lt[51][i].in[0] <== in[i];
		lt[51][i].in[1] <== 91;
		and[36][i] = AND();
		and[36][i].a <== lt[50][i].out;
		and[36][i].b <== lt[51][i].out;
		lt[52][i] = LessThan(8);
		lt[52][i].in[0] <== 96;
		lt[52][i].in[1] <== in[i];
		lt[53][i] = LessThan(8);
		lt[53][i].in[0] <== in[i];
		lt[53][i].in[1] <== 123;
		and[37][i] = AND();
		and[37][i].a <== lt[52][i].out;
		and[37][i].b <== lt[53][i].out;
		eq[72][i] = IsEqual();
		eq[72][i].in[0] <== in[i];
		eq[72][i].in[1] <== 91;
		eq[73][i] = IsEqual();
		eq[73][i].in[0] <== in[i];
		eq[73][i].in[1] <== 34;
		eq[74][i] = IsEqual();
		eq[74][i].in[0] <== in[i];
		eq[74][i].in[1] <== 45;
		eq[75][i] = IsEqual();
		eq[75][i].in[0] <== in[i];
		eq[75][i].in[1] <== 44;
		eq[76][i] = IsEqual();
		eq[76][i].in[0] <== in[i];
		eq[76][i].in[1] <== 46;
		eq[77][i] = IsEqual();
		eq[77][i].in[0] <== in[i];
		eq[77][i].in[1] <== 93;
		and[38][i] = AND();
		and[38][i].a <== states[i][3];
		multi_or[13][i] = MultiOR(9);
		multi_or[13][i].in[0] <== and[35][i].out;
		multi_or[13][i].in[1] <== and[36][i].out;
		multi_or[13][i].in[2] <== and[37][i].out;
		multi_or[13][i].in[3] <== eq[72][i].out;
		multi_or[13][i].in[4] <== eq[73][i].out;
		multi_or[13][i].in[5] <== eq[74][i].out;
		multi_or[13][i].in[6] <== eq[75][i].out;
		multi_or[13][i].in[7] <== eq[76][i].out;
		multi_or[13][i].in[8] <== eq[77][i].out;
		and[38][i].b <== multi_or[13][i].out;
		multi_or[14][i] = MultiOR(4);
		multi_or[14][i].in[0] <== and[29][i].out;
		multi_or[14][i].in[1] <== and[30][i].out;
		multi_or[14][i].in[2] <== and[34][i].out;
		multi_or[14][i].in[3] <== and[38][i].out;
		states[i+1][3] <== multi_or[14][i].out;
	}

	signal final_state_sum[num_bytes+1];
	final_state_sum[0] <== states[0][3];
	for (var i = 1; i <= num_bytes; i++) {
		final_state_sum[i] <== final_state_sum[i-1] + states[i][3];
	}
	out <== final_state_sum[num_bytes];

	signal is_substr0[msg_bytes][6];
	signal output reveal0[msg_bytes];
	for (var i = 0; i < msg_bytes; i++) {
		is_substr0[i][0] <== 0;
		is_substr0[i][1] <== is_substr0[i][0] + states[i+1][0] * states[i+2][1];
		is_substr0[i][2] <== is_substr0[i][1] + states[i+1][2] * states[i+2][3];
		is_substr0[i][3] <== is_substr0[i][2] + states[i+1][3] * states[i+2][3];
		is_substr0[i][4] <== is_substr0[i][3] + states[i+1][1] * states[i+2][1];
		is_substr0[i][5] <== is_substr0[i][4] + states[i+1][1] * states[i+2][2];
		reveal0[i] <== in[i+1] * is_substr0[i][5];
	}
}