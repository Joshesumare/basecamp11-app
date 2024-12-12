//*#[starknet::contract]
//*pub mod counter_contract {
//*     #[storage]
//    struct Storage {
//        pub counter: u32,
//    }
//}
#[starknet::contract]
pub mod StorageVariablesExample {
    // You need to import these storage functions to read and write to storage variables
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
 
    // All storage variables are contained in a struct called Storage
    // annotated with the `#[storage]` attribute
    #[storage]
    struct Storage {
        // Storage variable holding a number
        pub counter: u32
    }
 
    #[abi(embed_v0)]
    impl StorageVariablesExample of super::IStorageVariableExample<ContractState> {
        // Write to storage variables by sending a transaction
        // that calls an external function
        fn _set(ref self: ContractState, counter: u32) {
            self._counter.write(counter);
        }
 
        // Read from storage variables without sending transactions
        fn get(self: @ContractState) -> u32 {
            self._counter.read()
        }
    }
}