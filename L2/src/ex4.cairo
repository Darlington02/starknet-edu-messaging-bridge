%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1

@storage_var
    func l1_contract_address() -> (address: felt):
end

@storage_var
    func store_rand_value() -> (value: felt):
end

func constructor{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(_l1_contract_address: felt):
    # set L1 address
    l1_contract_address.write(_l1_contract_address)
    return()
end

@l1_handler
func deposit{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(from_address: felt, l2ReceiverContract: felt, rand_value: felt):
    # check that from_address is same as l1 address
    let (l1_address) = l1_contract_address.read()
    with_attr error_message("Wrong Contract Address"):
        assert l1_address = from_address
    end

    store_rand_value.write(rand_value)
    return()
end