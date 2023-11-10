// THIS IS AN AUTOGENERATED FILE. DO NOT EDIT THIS FILE DIRECTLY.

import {
  TypedMap,
  Entity,
  Value,
  ValueKind,
  store,
  Bytes,
  BigInt,
  BigDecimal
} from "@graphprotocol/graph-ts";

export class Relayer extends Entity {
  constructor(id: Bytes) {
    super();
    this.set("id", Value.fromBytes(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id != null, "Cannot save Relayer entity without an ID");
    if (id) {
      assert(
        id.kind == ValueKind.BYTES,
        `Entities of type Relayer must have an ID of type Bytes but the id '${id.displayData()}' is of type ${id.displayKind()}`
      );
      store.set("Relayer", id.toBytes().toHexString(), this);
    }
  }

  static loadInBlock(id: Bytes): Relayer | null {
    return changetype<Relayer | null>(
      store.get_in_block("Relayer", id.toHexString())
    );
  }

  static load(id: Bytes): Relayer | null {
    return changetype<Relayer | null>(store.get("Relayer", id.toHexString()));
  }

  get id(): Bytes {
    let value = this.get("id");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set id(value: Bytes) {
    this.set("id", Value.fromBytes(value));
  }

  get address(): Bytes {
    let value = this.get("address");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set address(value: Bytes) {
    this.set("address", Value.fromBytes(value));
  }

  get randHash(): Bytes {
    let value = this.get("randHash");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set randHash(value: Bytes) {
    this.set("randHash", Value.fromBytes(value));
  }

  get emailAddress(): string {
    let value = this.get("emailAddress");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toString();
    }
  }

  set emailAddress(value: string) {
    this.set("emailAddress", Value.fromString(value));
  }

  get hostname(): string {
    let value = this.get("hostname");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toString();
    }
  }

  set hostname(value: string) {
    this.set("hostname", Value.fromString(value));
  }

  get relayerAccounts(): RelayerAccountLoader {
    return new RelayerAccountLoader(
      "Relayer",
      this.get("id")!
        .toBytes()
        .toHexString(),
      "relayerAccounts"
    );
  }

  get createdAt(): BigInt {
    let value = this.get("createdAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set createdAt(value: BigInt) {
    this.set("createdAt", Value.fromBigInt(value));
  }

  get updatedAt(): BigInt {
    let value = this.get("updatedAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set updatedAt(value: BigInt) {
    this.set("updatedAt", Value.fromBigInt(value));
  }
}

export class RelayerAccount extends Entity {
  constructor(id: Bytes) {
    super();
    this.set("id", Value.fromBytes(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id != null, "Cannot save RelayerAccount entity without an ID");
    if (id) {
      assert(
        id.kind == ValueKind.BYTES,
        `Entities of type RelayerAccount must have an ID of type Bytes but the id '${id.displayData()}' is of type ${id.displayKind()}`
      );
      store.set("RelayerAccount", id.toBytes().toHexString(), this);
    }
  }

  static loadInBlock(id: Bytes): RelayerAccount | null {
    return changetype<RelayerAccount | null>(
      store.get_in_block("RelayerAccount", id.toHexString())
    );
  }

  static load(id: Bytes): RelayerAccount | null {
    return changetype<RelayerAccount | null>(
      store.get("RelayerAccount", id.toHexString())
    );
  }

  get id(): Bytes {
    let value = this.get("id");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set id(value: Bytes) {
    this.set("id", Value.fromBytes(value));
  }

  get relayer(): Bytes {
    let value = this.get("relayer");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set relayer(value: Bytes) {
    this.set("relayer", Value.fromBytes(value));
  }

  get account(): Bytes {
    let value = this.get("account");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set account(value: Bytes) {
    this.set("account", Value.fromBytes(value));
  }

  get emailAddrPointer(): Bytes {
    let value = this.get("emailAddrPointer");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set emailAddrPointer(value: Bytes) {
    this.set("emailAddrPointer", Value.fromBytes(value));
  }

  get accountKeyCommit(): Bytes {
    let value = this.get("accountKeyCommit");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set accountKeyCommit(value: Bytes) {
    this.set("accountKeyCommit", Value.fromBytes(value));
  }

  get psiPoint(): Bytes {
    let value = this.get("psiPoint");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set psiPoint(value: Bytes) {
    this.set("psiPoint", Value.fromBytes(value));
  }

  get isInitialized(): boolean {
    let value = this.get("isInitialized");
    if (!value || value.kind == ValueKind.NULL) {
      return false;
    } else {
      return value.toBoolean();
    }
  }

  set isInitialized(value: boolean) {
    this.set("isInitialized", Value.fromBoolean(value));
  }

  get createdAt(): BigInt {
    let value = this.get("createdAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set createdAt(value: BigInt) {
    this.set("createdAt", Value.fromBigInt(value));
  }

  get initializedAt(): BigInt {
    let value = this.get("initializedAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set initializedAt(value: BigInt) {
    this.set("initializedAt", Value.fromBigInt(value));
  }
}

export class Account extends Entity {
  constructor(id: Bytes) {
    super();
    this.set("id", Value.fromBytes(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id != null, "Cannot save Account entity without an ID");
    if (id) {
      assert(
        id.kind == ValueKind.BYTES,
        `Entities of type Account must have an ID of type Bytes but the id '${id.displayData()}' is of type ${id.displayKind()}`
      );
      store.set("Account", id.toBytes().toHexString(), this);
    }
  }

  static loadInBlock(id: Bytes): Account | null {
    return changetype<Account | null>(
      store.get_in_block("Account", id.toHexString())
    );
  }

  static load(id: Bytes): Account | null {
    return changetype<Account | null>(store.get("Account", id.toHexString()));
  }

  get id(): Bytes {
    let value = this.get("id");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set id(value: Bytes) {
    this.set("id", Value.fromBytes(value));
  }

  get relayerAccounts(): RelayerAccountLoader {
    return new RelayerAccountLoader(
      "Account",
      this.get("id")!
        .toBytes()
        .toHexString(),
      "relayerAccounts"
    );
  }

  get walletSalt(): Bytes {
    let value = this.get("walletSalt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set walletSalt(value: Bytes) {
    this.set("walletSalt", Value.fromBytes(value));
  }

  get walletAddr(): Bytes {
    let value = this.get("walletAddr");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set walletAddr(value: Bytes) {
    this.set("walletAddr", Value.fromBytes(value));
  }

  get createdAt(): BigInt {
    let value = this.get("createdAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set createdAt(value: BigInt) {
    this.set("createdAt", Value.fromBigInt(value));
  }
}

export class UnclaimedFund extends Entity {
  constructor(id: string) {
    super();
    this.set("id", Value.fromString(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id != null, "Cannot save UnclaimedFund entity without an ID");
    if (id) {
      assert(
        id.kind == ValueKind.STRING,
        `Entities of type UnclaimedFund must have an ID of type String but the id '${id.displayData()}' is of type ${id.displayKind()}`
      );
      store.set("UnclaimedFund", id.toString(), this);
    }
  }

  static loadInBlock(id: string): UnclaimedFund | null {
    return changetype<UnclaimedFund | null>(
      store.get_in_block("UnclaimedFund", id)
    );
  }

  static load(id: string): UnclaimedFund | null {
    return changetype<UnclaimedFund | null>(store.get("UnclaimedFund", id));
  }

  get id(): string {
    let value = this.get("id");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toString();
    }
  }

  set id(value: string) {
    this.set("id", Value.fromString(value));
  }

  get emailAddrCommit(): Bytes {
    let value = this.get("emailAddrCommit");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set emailAddrCommit(value: Bytes) {
    this.set("emailAddrCommit", Value.fromBytes(value));
  }

  get tokenAddr(): Bytes {
    let value = this.get("tokenAddr");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set tokenAddr(value: Bytes) {
    this.set("tokenAddr", Value.fromBytes(value));
  }

  get amount(): BigInt {
    let value = this.get("amount");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set amount(value: BigInt) {
    this.set("amount", Value.fromBigInt(value));
  }

  get sender(): Bytes {
    let value = this.get("sender");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set sender(value: Bytes) {
    this.set("sender", Value.fromBytes(value));
  }

  get expiryTime(): BigInt {
    let value = this.get("expiryTime");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set expiryTime(value: BigInt) {
    this.set("expiryTime", Value.fromBigInt(value));
  }

  get commitmentRandomness(): BigInt {
    let value = this.get("commitmentRandomness");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set commitmentRandomness(value: BigInt) {
    this.set("commitmentRandomness", Value.fromBigInt(value));
  }

  get emailAddr(): string {
    let value = this.get("emailAddr");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toString();
    }
  }

  set emailAddr(value: string) {
    this.set("emailAddr", Value.fromString(value));
  }

  get recipient(): Bytes {
    let value = this.get("recipient");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set recipient(value: Bytes) {
    this.set("recipient", Value.fromBytes(value));
  }

  get createdAt(): BigInt {
    let value = this.get("createdAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set createdAt(value: BigInt) {
    this.set("createdAt", Value.fromBigInt(value));
  }

  get claimedAt(): BigInt {
    let value = this.get("claimedAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set claimedAt(value: BigInt) {
    this.set("claimedAt", Value.fromBigInt(value));
  }

  get voidedAt(): BigInt {
    let value = this.get("voidedAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set voidedAt(value: BigInt) {
    this.set("voidedAt", Value.fromBigInt(value));
  }
}

export class UnclaimedState extends Entity {
  constructor(id: string) {
    super();
    this.set("id", Value.fromString(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id != null, "Cannot save UnclaimedState entity without an ID");
    if (id) {
      assert(
        id.kind == ValueKind.STRING,
        `Entities of type UnclaimedState must have an ID of type String but the id '${id.displayData()}' is of type ${id.displayKind()}`
      );
      store.set("UnclaimedState", id.toString(), this);
    }
  }

  static loadInBlock(id: string): UnclaimedState | null {
    return changetype<UnclaimedState | null>(
      store.get_in_block("UnclaimedState", id)
    );
  }

  static load(id: string): UnclaimedState | null {
    return changetype<UnclaimedState | null>(store.get("UnclaimedState", id));
  }

  get id(): string {
    let value = this.get("id");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toString();
    }
  }

  set id(value: string) {
    this.set("id", Value.fromString(value));
  }

  get emailAddrCommit(): Bytes {
    let value = this.get("emailAddrCommit");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set emailAddrCommit(value: Bytes) {
    this.set("emailAddrCommit", Value.fromBytes(value));
  }

  get extensionAddr(): Bytes {
    let value = this.get("extensionAddr");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set extensionAddr(value: Bytes) {
    this.set("extensionAddr", Value.fromBytes(value));
  }

  get sender(): Bytes {
    let value = this.get("sender");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set sender(value: Bytes) {
    this.set("sender", Value.fromBytes(value));
  }

  get expiryTime(): BigInt {
    let value = this.get("expiryTime");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set expiryTime(value: BigInt) {
    this.set("expiryTime", Value.fromBigInt(value));
  }

  get state(): Bytes {
    let value = this.get("state");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set state(value: Bytes) {
    this.set("state", Value.fromBytes(value));
  }

  get commitmentRandomness(): BigInt {
    let value = this.get("commitmentRandomness");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set commitmentRandomness(value: BigInt) {
    this.set("commitmentRandomness", Value.fromBigInt(value));
  }

  get emailAddr(): string {
    let value = this.get("emailAddr");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toString();
    }
  }

  set emailAddr(value: string) {
    this.set("emailAddr", Value.fromString(value));
  }

  get recipient(): Bytes {
    let value = this.get("recipient");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set recipient(value: Bytes) {
    this.set("recipient", Value.fromBytes(value));
  }

  get createdAt(): BigInt {
    let value = this.get("createdAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set createdAt(value: BigInt) {
    this.set("createdAt", Value.fromBigInt(value));
  }

  get claimedAt(): BigInt {
    let value = this.get("claimedAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set claimedAt(value: BigInt) {
    this.set("claimedAt", Value.fromBigInt(value));
  }

  get voidedAt(): BigInt {
    let value = this.get("voidedAt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBigInt();
    }
  }

  set voidedAt(value: BigInt) {
    this.set("voidedAt", Value.fromBigInt(value));
  }
}

export class RelayerAccountLoader extends Entity {
  _entity: string;
  _field: string;
  _id: string;

  constructor(entity: string, id: string, field: string) {
    super();
    this._entity = entity;
    this._id = id;
    this._field = field;
  }

  load(): RelayerAccount[] {
    let value = store.loadRelated(this._entity, this._id, this._field);
    return changetype<RelayerAccount[]>(value);
  }
}

export class AccountCreation extends Entity {
  constructor(id: Bytes) {
    super();
    this.set("id", Value.fromBytes(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id != null, "Cannot save AccountCreation entity without an ID");
    if (id) {
      assert(
        id.kind == ValueKind.BYTES,
        `Entities of type AccountCreation must have an ID of type Bytes but the id '${id.displayData()}' is of type ${id.displayKind()}`
      );
      store.set("AccountCreation", id.toBytes().toHexString(), this);
    }
  }

  static loadInBlock(id: Bytes): AccountCreation | null {
    return changetype<AccountCreation | null>(
      store.get_in_block("AccountCreation", id.toHexString())
    );
  }

  static load(id: Bytes): AccountCreation | null {
    return changetype<AccountCreation | null>(
      store.get("AccountCreation", id.toHexString())
    );
  }

  get id(): Bytes {
    let value = this.get("id");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set id(value: Bytes) {
    this.set("id", Value.fromBytes(value));
  }

  get emailAddrPointer(): Bytes {
    let value = this.get("emailAddrPointer");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set emailAddrPointer(value: Bytes) {
    this.set("emailAddrPointer", Value.fromBytes(value));
  }

  get accountKeyCommit(): Bytes {
    let value = this.get("accountKeyCommit");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set accountKeyCommit(value: Bytes) {
    this.set("accountKeyCommit", Value.fromBytes(value));
  }

  get walletSalt(): Bytes {
    let value = this.get("walletSalt");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set walletSalt(value: Bytes) {
    this.set("walletSalt", Value.fromBytes(value));
  }

  get psiPoint(): Bytes {
    let value = this.get("psiPoint");
    if (!value || value.kind == ValueKind.NULL) {
      throw new Error("Cannot return null for a required field.");
    } else {
      return value.toBytes();
    }
  }

  set psiPoint(value: Bytes) {
    this.set("psiPoint", Value.fromBytes(value));
  }
}
