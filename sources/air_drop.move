    module my_addrx::air_drop{
        use aptos_framework::aptos_coin::AptosCoin;
        use aptos_framework::coin::{Self, Coin};
        use aptos_framework::timestamp;
        use aptos_framework::account;
        use aptos_framework::account::SignerCapability;
        use aptos_framework::guid;

        use std::signer;
        use std::option::{Self, Option, some};
        use std::string::String;
        use std::vector;
        use aptos_std::event::{Self, EventHandle};
        use aptos_std::table::{Self, Table};



        const ERROR_INVALID_BUYER: u64 = 0;
        const ERROR_INVALID_OWNER: u64 = 2;

        struct ClaimAirdropEvent has store, drop {
              id: TokenId,
              auction_id: u64,
              timestamp: u64,
              bidder_address: address
             }

        struct EligibleForDropEvent has store , drop {
            selected:bool,
             timestamp:u64
         }    

        struct AirDrop has key ,store {
              level:u8,
              name:String,
              account:address,
              airdrop_event:EventHandle<ClaimAirdropEvent>,
              selected_event: EventHandle<EligibleForDropEvent>
         }

        struct StoreAirDropUsers has key {
              list_of_users : vector<AirDrop>
         }


        public entry fun initial_airdrop_script(sender :&signer){

            let sender_addr = signer::address_of(sender);
            let (market_signer , market_cap) = account::create_resource_account(sender,b"oe");
            let market_signer_addr = signer::address_of(&market_signer);

            assert!(sender == @my_addrx,ERROR_INVALID_OWNER);

            if(!exists<StoreAirDropUsers>(market_signer_addr)){
                move_to(market_signer, StoreAirDropUsers{
                    list_of_users:vector::empty<AirDrop>()
                })
            };

        }  


        public fun make_user_eligible_for_airdrop(accoutn:&signer, air_drop:AirDrop, store_air_drop:StoreAirDropUsers ) {
            
             let account_addr : address = signer::address_of(account);
             assert!(account_addr != @my_addrx , ERROR_INVALID_BUYER);
            //  assert!(exists<StoreAirDropUsers>())

              move_to(account , air_drop );

       }  

              











                
     }