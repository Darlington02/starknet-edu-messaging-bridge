%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1


const L1_CONTRACT_ADDRESS = 732664983080715136788290267553922222853235868025


@storage_var
    func store_rand_value() -> (value: felt):
end

@l1_handler
func deposit{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(from_address: felt, rand_value: felt):
    # check that from_address is same as l1 address
    with_attr error_message("Wrong Contract Address"):
        assert L1_CONTRACT_ADDRESS = from_address
    end

    store_rand_value.write(rand_value)
    return()
end