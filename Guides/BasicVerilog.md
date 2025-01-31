### 1. Install Icarus Verilog
Install Icarus Verilog, a popular open-source Verilog simulation and synthesis tool:
```sh
sudo apt update
sudo apt install iverilog
```

### 2. Navigate to the Project Directory
Change your current directory to the Examples folder where your Verilog files are located:
```sh
cd Examples
```

### 3. Compile and Run a Verilog File
Use iverilog to compile your Verilog source file (hello.v) into an output file (hello.out):
```sh
iverilog -o hello.out hello.v
vvp hello.out
```