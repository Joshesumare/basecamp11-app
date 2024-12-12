#[starknet::contract]
pub mod ExampleContract {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
 
    #[storage]
    struct Storage {
        pub valor: u32
    }
 
    // The `#[abi(embed_v0)]` attribute indicates that all
    // the functions in this implementation can be called externally.
    // Omitting this attribute would make all the functions internal.
    #[abi(embed_v0)]
    impl ExampleContract of super::IExampleContract<ContractState> {
        // The `set` function can be called externally
        // because it is written inside an implementation marked as `#[abi(embed_v0)]`.
        // It can modify the contract's state as it is passed as a reference.
        fn set(ref self: ContractState, valor: u32) {
            self.value.write(valor);
        }
 
        // The `get` function can be called externally
        // because it is written inside an implementation marked as `#[abi(embed_v0)]`.
        // However, it can't modify the contract's state, as it is passed as a snapshot
        // -> It's only a "view" function.
        fn get(self: @ContractState) -> u32 {
            // We can call an internal function from any functions within the contract
            PrivateFunctionsTrait::_read_valor(self)
        }
    }
 
    // The lack of the `#[abi(embed_v0)]` attribute indicates that all the functions in
    // this implementation can only be called internally.
    // We name the trait `PrivateFunctionsTrait` to indicate that it is an
    // internal trait allowing us to call internal functions.
    #[generate_trait]
    pub impl PrivateFunctions of PrivateFunctionsTrait {
        // The `_read_value` function is outside the implementation that is
        // marked as `#[abi(embed_v0)]`, so it's an _internal_ function
        // and can only be called from within the contract.
        // However, it can't modify the contract's state, as it is passed
        // as a snapshot: it is only a "view" function.
        fn _read_valor(self: @ContractState) -> u32 {
            self.valor.read()
        }
    }
}










































//#[starknet::interface]
//trait Counter<ContractState> {
    //fn getcounter (self: @ContractState) -> u32;
    //fn increasecounter (ref self: ContractState);
    //fn decreasecounter (ref self: ContractState);
   // fn resetcounter (ref self: ContractState);
//}


//#[starknet::contract]
//pub mod counter {
   // use openzeppelin_access::ownable::OwnableComponent;
   // use starknet::ContractAddress;
    //use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    //component!(path: OwnableComponent, storage: ownable, event: OwnableEvent);

    //Ownable Mixin
   // #[abi(embed_v0)]
   // impl OwnableMixinImpl = OwnableComponent::OwnableMixinImpl<ContractState>;
  //  impl InternalImpl = OwnableComponent::InternalImpl<ContractState>;
//
//*    #[storage]
//*    struct Storage {
  //      pub counter: u32,
 //       pub newcounter: u32,
  //      pub oldcounter: u32,
 //       #[substorage(v0)]
 //       ownable: OwnableComponent::Storage,
  //  }

  //  #[event]
  //  #[derive(Drop, starknet::Event)]
  //  pub enum Event {
 //       CounterIncreased: CounterIncreased,
  //      CounterDecreased: CounterDecreased,
   //     #[flat]
 //       OwnableEvent: OwnableComponent::Event,
 //   }
//
 //   #[derive(Drop, starknet::Event)]
 //   struct CounterIncreased {
 //       counter: u32,
   // }
//
  //  #[derive(Drop, starknet::Event)]
  //  struct CounterDecreased {
 //       counter: u32,
    //}
////
  //  #[constructor]
   // fn constructor(ref self: ContractState, init_value: u32, owner: ContractAddress) {
 //       self.counter.write(init_value);
 //       self.ownable.initializer(owner);
  //  }

 //   #[abi(embed_v0)]
  //  impl counter of super::Counter<ContractState> {
 //       fn get (self: counter) -> u32 {
  //      self.value.read()
 //       }
//    }
//}
       // fn increasecounter (ref self: TContractState) {
       //     let oldcounter = self.counter.read();
       //     let newcounter = oldcounter + 1;
       //     self.counter.write(newcounter);
       //     self.emit(CounterIncreased { counter: newcounter });
       // }
       // fn decreasecounter (ref self: TContractState) {
         //   let oldcounter = self.counter.read();
         //   assert(oldcounter < 1, 'Counter can\'t be negative')
        //    let newcounter = oldcounter - 1;
        //    self.counter.write(new_counter);
        //    self.emit(CounterDecreased { counter: newcounter });
        //}

       // fn resetcounter (ref self: TContractState) {
       //     self.ownable.assert_only_owner();
       //     self.counter.write(0);
       // }
  // }
//}
