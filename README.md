# Basecamp11

This repository is create for study cairo in spanish
Este repositorio esta creado para comprender las estructuras de Cairo


Usar [Cairo book](https://book.cairo-lang.org/ch00-00-introduction.html) and the [Starknet docs](https://docs.starknet.io/documentation/) como referencia.

## Setup

este repositorio fue creado tomando como base el https://github.com/starknet-edu/basecamp11-app, puedes clonarlo total o parcial sin problemas:


### instalacion opcion 1: Without Docker

1. Install `asdf` ([instructions](https://asdf-vm.com/guide/getting-started.html))
2. Install Scarb `2.8.5` via `asdf` ([instructions](https://docs.swmansion.com/scarb/download.html#install-via-asdf))
3. Install Starknet Foundry `0.33.0` via `asdf` ([instructions](https://foundry-rs.github.io/starknet-foundry/getting-started/installation.html))
4. Install Rust via ([instructions](https://www.rust-lang.org/tools/install))
5. Install the Cairo 1.0 extension for VSCode ([marketplace](https://foundry-rs.github.io/starknet-foundry/getting-started/installation.html#installation-via-asdf))


### instalacion opcion 2: With Docker

4. Make sure Docker is installed and running
5. Install the Dev Containers extension for VSCode ([marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers))
6. Launch an instance of VSCode inside of the container by going to **View -> Command Palette -> Dev Containers: Rebuild and Reopen in Container**

> **Note:** All the commands shown from this point on will assume that you are using the integrated terminal of a VSCode instance running inside the container. If you want to run the tests on a different terminal you'll need to use the command `docker compose run test`.

## Instalacion de dependencias 


- Para crear un proyecto con `Scarb`, tendremos que crear archivo llamado `.devcontainer.json` en el root, y le escribiremos el siguiente codigo:

  ```rust
  {
      "name": "dev",
      "image": "starknetfoundation/starknet-dev:2.9.1",
  }
  ```

  Posterior a eso y para ejecutar instancias en VSCode, ir al menu superior View -> Command Palette y ejecutar el siguiente codigo // Dev Containers: Rebuild and Reopen in Container //

  Desde ahora cada vez que modifiquemos algun archivo con instancias deberemos hacer lo mismo solo que modificaremos el comando por el siguinete // Dev Containers: Rebuild //

- Ahora para iniciar Scarb deberemos abrir el terminal y en el terminal escribir lo siguiente 
 `scarb init` al presionar enter se deplagara un menu en el cual deberemos seleccionar 
   > Starknet Foundry (default)
 


A continuacion se crearan los siguientes archivos y carpetas
```

  > src                     /* Carpeta
      >lib.cairo            /* archivo
  >test                     /* carpeta
      >test_contract.cairo  /* archivo
  >.gitignore               /* archivo
  >Scarb.lock               /* archivo
  >Scarb.toml               /* archivo
  >Snfoundry.toml           /* archivo
```


## Dependencias Openzeppelin.

 Ahora para instalar las dependencias de openzeppelin lo podemos hacer de dos formas

  - Forma 1: 
    En el archivo "Scarb.toml" agregar en el apartado [dependencies] lo siguiente. 
     ```rust
      > [Dependencies]
      openzeppelin_access = "0.19.0"
      starknet = "2.9.1" // Esto ya estaba configurado, pero debemos revisar que este de acuerdo a la version del archivo '.devcontainer.json' 
      ```

  - Forma 2:
    En la terminal digitamos:
    ```rust
          <scarb add openzeppelin_acces@0.19.0>
    ```
    Al presionar enter, el programa descargara los archivos necesarios y ademas añadira la linea de codigo señalada anteriormente al archivo "Scarb.toml"


## Modificacion archivo .devcointainer.json

Abriremos el archivo llamado `.devcontainer.json` en el root, y le añadiremos el siguiente codigo:

  ```rust
  { 
  //  "name": "dev",
  //  "image": "starknetfoundation/starknet-dev:2.9.1",
    "customizations": {
        "vscode": {
            "extensions": [
                "StarkWare.cairo1",
                "tamasfe.even-better-toml"
            ]
        }
    }
}
  ```


- **Note:** Lo que se encuentra demarcado es lo que ya habiamos incorporado.
- **Note:** cada vez que modifiquemos algun archivo con instancias deberemos reconstruir el contenedor // Dev Containers: Rebuild //.



### Creacion de archivos base

- crearemos dos archivos en la carpeta "src" 
  - Archivo llamado `counter.cairo`, con el siguiente codigo:
    ```rust
      #[starknet::contract]
        pub mod counter_contract {
        #[storage]
          struct Storage {}
          }
    ```
  - Archivo llamado the `lib.cairo`, con el siguiente codigo:

    ```rust
    pub mod counter;

    ```

> **Note:** Cada vez que editemos los archivos debemos digitar los siguientes comandos.

            scarb fmt   // Verifca el formato del los comandos ingresados
            scarb build // Verifica el codigo,

### Verificacion

Una vez completados los pasos anteriores, executaremos el tester de la suit para verficar que todos los requerimientos esten listos para comenzar a crear nuestro codigo.

```bash
scarb test
```

### Hints

## Step 3

### Goal

Implement the constructor function to initialize an input number and store a variable named `counter` within the contract.

### Requirements

- Store a variable named `counter` as `u32` type in the `Storage` struct.
- Implement the constructor function that initializes the `counter` variable with a given input value.
- The input variable of the constructor function should be named `initial_value`

```rust
#[starknet::contract]
pub mod counter_contract {
    #[storage]
    struct Storage {
        pub counter:u32, //Establece la variable como u32, numero y la almacena
    }
}
```

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- Storage variables are the most common way to interact with your contract storage. You can read more about it in [Chapter 14 - Contract Storage](https://book.cairo-lang.org/ch14-01-00-contract-storage.html#contract-storage).
- The constructor function is a special type of function that runs only once. You can read more about it in [Chapter 14 - Constructors](https://book.cairo-lang.org/ch14-02-contract-functions.html#1-constructors).

## Step 4

Switch to the `step4` branch to enable the verification tests:

```bash
git checkout -b step4 origin/step4
```

### Goal

Implement an interface for the contract which contains the `get_counter()` function. This function should return the value of the stored `counter` variable within the contract.

### Requirements

- Implement an interface for a function named `get_counter()` which returns the value of the `counter` variable.
- The `get_counter()` function must be within the contract's interface named `ICounter`.

> **Note:** Any other given name to the contract's interface would break the test, be sure to have to correct name!

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- To create a contract interface, you will need to define a trait with the name `ICounter` (otherwise the tests will fail) and mark the trait with the `[starknet::interface]` attribute. You can read more about it in [Chapter 13 Anatomy of a Simple Contract](https://book.cairo-lang.org/ch13-02-anatomy-of-a-simple-contract.html#the-interface-the-contracts-blueprint).
- The `get_counter()` function should only be able to read the state of the contract and not modify it. You can read more about it in [Chapter 14 - View Functions](https://book.cairo-lang.org/ch14-02-contract-functions.html#view-functions).

## Step 5

Switch to the `step5` branch to enable the verification tests:

```bash
git checkout -b step5 origin/step5
```

### Goal

Within the same interface created in the previous step, implement a function called `increase_counter()` that can increment the current value of the `counter` by `1` each time it is invoked.

### Requirements

- Implement a function named `increase_counter()` which increments the `counter` value by `1`.
- The `increase_counter()` function must be within the contract's interface named `ICounter`.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- The `increase_counter()` function should be able to modify the state of the contract (also called an external function) and update the `counter` value within the `Storage`. You can read more about it in [Chapter 14 - External Functions](https://book.cairo-lang.org/ch14-02-contract-functions.html#external-functions).

## Step 6

Switch to the `step6` branch to enable the verification tests:

```bash
git checkout -b step6 origin/step6
```

### Goal

Implement an event named `CounterIncreased` that emits the current value of the `counter` variable, every time the value is increased.

### Requirements

- Define a variant named `CounterIncreased` in the `Event` enum.
- Defining the `value` variable within the `CounterIncrease` struct.
- Emit the event in the `increase_counter()` function with the new value, once the `counter` value has been incremented.
- Make them public to grant the test suite access (this includes the `Enum`, `struct` and `value`).

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- Events are custom data structures that are emitted by a contract. More information about Events can be found in [Chapter 14 - Contract Events](https://book.cairo-lang.org/ch14-03-contract-events.html).
- To emit an event, you can use the `self.emit()` function as show [here](https://book.cairo-lang.org/ch14-03-contract-events.html#emitting-events).

---

> **Note:** CHECKPOINT Reached ⛳️! Switch to the `step15-js` branch to get a deployment script based on starknet.js.
>
> ```bash
> git checkout -b step15-js origin/step15-js
> ```

---

## Step 7

Switch to the `step7` branch to enable the verification tests:

```bash
git checkout -b step7 origin/step7
```

### Goal

In this step, we will introduce an external smart contract that acts as a kill switch for a specific function. Your task is to add the external `KillSwitch` contract as a dependency within your project.

> **Note:** The `KillSwitch` contract can be found [here](https://github.com/starknet-edu/kill-switch).

### Requirements

- In your `Scarb.toml` file, declare the `kill_switch` package as your project dependency under the `[dependencies]` section.
- In your `Scarb.toml` file, to allow compilation of external contracts for Starknet Foundry, add the following line under the `[[target.starknet-contract]]` section.
  ```toml
  build-external-contracts = ["kill_switch::KillSwitch"]
  ```

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- Refer to the [Scarb Managing Dependencies Documention](https://docs.swmansion.com/scarb/docs/guides/dependencies.html) for more information.
- Refer to the [Compiling External Cotnract](https://docs.swmansion.com/scarb/docs/extensions/starknet/contract-target.html#compiling-external-contracts) for more information.

## Step 8

Switch to the `step8` branch to enable the verification tests:

```bash
git checkout -b step8 origin/step8
```

### Goal

Initialize the `KillSwitch` contract by storing the contract's address given as an input variable in the constructor function.

### Requirements

1. Store a variable named `kill_switch` as type `ContractAddress`.
2. Update the constructor function to initialize the `kill_switch` variable.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- The task is similar to Step 3. Refer to it for more information.

## Step 9

Switch to the `step9` branch to enable the verification tests:

```bash
git checkout -b step9 origin/step9
```

### Goal

Implement the `KillSwitch` mechanism in the `increase_counter()` by calling the `is_active()` function from the `KillSwitch` contract.

### Requirements

- If the function `is_active()` from the `KillSwitch` contract returns `false`, then allow the `increase_counter()` function to increment the value; otherwise, return without incrementing.

> **Note:** Analyze the `KillSwitch` code to understand the interface and the contract structure from [here](https://github.com/starknet-edu/kill-switch/blob/master/src/lib.cairo).

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- You need to import the `Dispatcher` and `DispatcherTrait` of the `KillSwitch` contract. These dispatchers are automatically created and exported by the compiler. More information about Contract Dispatcher can be found in [Chapter 15.2 - Contract Dispatcher](https://book.cairo-lang.org/ch15-02-interacting-with-another-contract.html#calling-contracts-using-the-contract-dispatcher).
- You can access the `is_active()` function from your `KillSwitch` contract dispatcher.
- You can use an `if` expression to implement the mechanism. Refer to the [Cairo Book](https://book.cairo-lang.org/ch02-05-control-flow.html) to learn more.

> **Note:** If you want to deploy the `Counter` contract, you can use the following deployed `KillSwitch` contract address.
>
> ## **Sepolia**
>
> Contract Address: `0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542`
>
> - [Voyager](https://sepolia.voyager.online/contract/0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542)
> - [Starkscan](https://sepolia.starkscan.co/contract/0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542)

## Step 10

Switch to the `step10` branch to enable the verification tests:

```bash
git checkout -b step10 origin/step10
```

### Goal

Protect the `increase_counter()` function by reverting the transaction if `KillSwitch` mechanism is enabled.

### Requirements

- Create the condition to revert the transaction if the `KillSwith` contract is enabled
- Revert the transaction with the following message `Kill Switch is active`

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- You can stop and revert a transaction with an error message using the `assert!()` macro. Refer to the [Cairo Book documentation](https://book.cairo-lang.org/ch10-01-how-to-write-tests.html#checking-results-with-the-assert-macro) to learn more.
- You can replace the `if` expression with the `assert!()` macro instead.

## Step 11

Switch to the `step11` branch to enable the verification tests:

```bash
git checkout -b step11 origin/step11
```

### Goal

Add the external `OpenZeppelin` contracts as a dependency within your project.

> **Note:** The `OpenZeppelin` contracts can be found [here](https://github.com/OpenZeppelin/cairo-contracts).

### Requirements

- In your `Scarb.toml` file, declare the `openzeppelin` package as your project dependency under the `[dependencies]` section.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- Specify the OpenZeppelin version as `0.19.0` in `Scarb.toml`.
- Refer to the [OZ Contracts for Cairo Documention](https://docs.openzeppelin.com/contracts-cairo/0.19.0/) for more information.

## Step 12

Switch to the `step12` branch to enable the verification tests:

```bash
git checkout -b step12 origin/step12
```

### Goal

Initialize the `Ownable` component from the OpenZeppelin contracts.

Before working on this step, make sure to read [Chapter 16.2: Composability and Components](https://book.cairo-lang.org/ch16-02-00-composability-and-components.html) and see how Components work.

### Requirements

- Declare the component inside your contract using the `component!()` macro.
- Add the path to the component's storage and events to the contract's `Storage` and `Event`.
- Embed the component's logic into your contract by creating an instance of the component's generic implementation with a specific `ContractState`.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- Refer to the [Using Components Inside a Contract](https://book.cairo-lang.org/ch16-02-00-composability-and-components.html#using-components-inside-a-contract) documentation to learn how to implement a component within a contract.

## Step 13

Switch to the `step13` branch to enable the verification tests:

```bash
git checkout -b step13 origin/step13
```

### Goal

Modify the constructor function to call the `initializer()` function within the `Ownable` component to initialize the owner.

### Requirements

- The input variable of the constructor function should be named `initial_owner`

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hint

- To call the `initializer()` function you can look at what functions `self.ownable` exposes.
- Refer to the [Ownable Component](https://github.com/OpenZeppelin/cairo-contracts/blob/main/packages/access/src/ownable/ownable.cairo) to learn more about the accessible function.

## Step 14

Switch to the `step14` branch to enable the verification tests
:

```bash
git checkout -b step14 origin/step14
```

### Goal

Protect the `increase_counter()` function so that only the owner of the contract can call this.

### Requirements

- Use the `assert_only_owner()` function from the Ownable Component.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- To call the `assert_only_owner()` function you can look at what functions `self.ownable` exposes.
- Check out the `assert_only_owner()` function from the [Ownable Component](https://github.com/OpenZeppelin/cairo-contracts/blob/main/packages/access/src/ownable/ownable.cairo) for more information.

## Step 15

Switch to the `step15-js` branch to get a deployment script based on [`starknet.js`](https://www.starknetjs.com/).

```bash
git checkout -b step15-js origin/step15-js
```

### Goal

To deploy your account contract to Starknet's testnet using the `deploy.ts` script found in the `scripts` folder.

### Dependencies

Run the command below from the project's root folder to install the deployment script dependencies.

```bash
npm install
```

### Deployer Wallet

Create a wallet that the script can use to pay for the declaration of your account contract.

### Steps

1. Create a wallet on Starknet testnet using the [Argent X](https://www.argent.xyz/argent-x/) or [Braavos](https://braavos.app/) browser extension.
2. Fund the wallet by using the [Faucet](https://starknet-faucet.vercel.app/) or the [Bridge](https://sepolia.starkgate.starknet.io/).
3. Create a file in the project's root folder called `.env`
4. Export the private key of the funded wallet and paste it into the `.env` file using the key `DEPLOYER_PRIVATE_KEY`.

```bash
DEPLOYER_PRIVATE_KEY=<YOUR_FUNDED_TESTNET_WALLET_PRIVATE_KEY>
```

5. Export the public key of the funded wallet and paste it into the `.env` file using the key `DEPLOYER_ADDRESS`

```bash
DEPLOYER_ADDRESS=<YOUR_FUNDED_TESTNET_WALLET_PUBLIC_ADDRESS>
```

### RPC Endpoint

To successfully deploy the contract with the script on the Starknet Testnet, you will need to provide an RPC URL. For our workshop, we will use Blast's Public RPC Endpoint.

Add the following line in your `.env` file:

```bash
RPC_ENDPOINT=https://starknet-sepolia.public.blastapi.io/
```

Refer to [Blast](https://blastapi.io/public-api/starknet) to learn more about their Starknet RPC Endpoints.

### Run the Script

Run the script that will declare and deploy your smart contract on the Starknet Testnet and ensure that you adjust the constructor inputs in your `deploy.ts` file appropriately.

> **Note:** If you are deploying the smart contract from the CHECKPOINT, in the `deploy.ts` file, you will only need the `initial_counter` in the `constructor` variable. Ensure that you remove or comment out the `kill_switch_address` and `initial_onwer` variables.
>
> Additionally, ensure that the variable names in the `deploy.ts` constructor are the same as in the `counter.cairo` constructor function.

```typescript
const constructor = myCallData.compile("constructor", {
  initial_counter: 100,
  address: "0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542",
  initial_owner: process.env.DEPLOYER_ADDRESS,
});
```

#### Steps

1. From the project's root folder run `npm run deploy`
2. Follow the instructions from the terminal

If the script finishes successfully your smart contract is ready to be used on Starknet testnet. Congratulations!