library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

--Usually name your testbench similar to below for clarify tb_<name>
entity tb_SimplifiedMIPSProcessor is
--Generic for half of the clock cycle period
  generic(gCLK_HPER   : time := 10 ns);  
end tb_SimplifiedMIPSProcessor;

architecture mixed of tb_SimplifiedMIPSProcessor is

--Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

--We will be making an instance of the file that we are testing
--TODO: Provide the appropriate port declarations for your processor
component singleCycle is
  port(clk		: in std_logic;
       RST		: in std_logic;
       Carry		: out std_logic;
       Overflow		: out std_logic;
       Zero		: out std_logic);
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';
signal zero, Carry, Overflow : std_logic;

-- TODO: Add any additional signals that you use in your test bench follow
signal instruction : std_logic_vector(31 downto 0) := (others => '0');
signal PCplus4, rt_data, rs_data : std_logic_vector(31 downto 0) := (others => '0');

begin



-- TODO: Make an instance of the component to test and wire all signals to the corresponding
-- input or output.
  MySimplifiedMIPSProcess: singleCycle
  port map(clk       => CLK,
           RST => reset,
           Carry  => Carry,
           Overflow => Overflow,
           Zero   => zero);
  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html
  --port map(CLK, reset, rs_sel, rt_sel, reg_we, w_addr, reg_dest, immediate, sel_imm, ALU_OP, shamt, mem_we, rs_data, rt_data, ALU_out, dmem_out);
  
  --This first process is to automate the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';
    wait for gCLK_HPER;
    CLK <= '0';
    wait for gCLK_HPER;
  end process;

    -- This process resets the processor.
  P_RST: process
  begin
  	reset <= '0';
    wait for gCLK_HPER;
	reset <= '1';
    wait for gCLK_HPER;
	reset <= '0';
	wait;
  end process;  
  
  -- Dumps modifications to the state of the processor to trace file
  P_DUMP_STATE: process (CLK) 
    file my_dump : TEXT open WRITE_MODE is "dump.out";
    variable my_line : LINE;
    variable cycle_cnt : integer := 0;
	variable halt : std_logic := '0';
    -- Setup your hierarchical/external names
    -- Reference for external names: https://www.doulos.com/knowhow/vhdl_designers_guide/vhdl_2008/vhdl_200x_ease/#hierarchicalnames
    alias memWr is <<signal MySimplifiedMIPSProcess.sMemWrite : std_logic>>;                            -- TODO: Fill out external signal
    alias memAddr is <<signal MySimplifiedMIPSProcess.dtpath.datapathOut : std_logic_vector(31 downto 0)>>;      -- TODO: Fill out external signal
    alias memData is <<signal MySimplifiedMIPSProcess.dtpath.sRt : std_logic_vector(31 downto 0)>>;      -- TODO: Fill out external signal

    alias regWr is <<signal MySimplifiedMIPSProcess.sRegWrite : std_logic>>;                            -- TODO: Fill out external signal
    alias regWrAddr is <<signal MySimplifiedMIPSProcess.sWriteReg : std_logic_vector(4 downto 0)>>;    -- TODO: Fill out external signal
    alias regWrData is <<signal MySimplifiedMIPSProcess.sDataWrite : std_logic_vector(31 downto 0)>>;    -- TODO: Fill out external signal

	alias inst is <<signal MySimplifiedMIPSProcess.instruction : std_logic_vector(31 downto 0)>>;    -- TODO: Fill out external signal
	alias v0Val is <<signal MySimplifiedMIPSProcess.dtpath.mips_datapath.regs.v0: std_logic_vector(31 downto 0)>>;    -- TODO: Fill out external signal
    --alias halt is <<signal FILLMEOUT : std_logic>>;                             -- TODO: Fill out external signal


  begin
    --if (cycle_cnt < 100) then
      if (rising_edge(CLK)) then
        if (regWr or memWr) then
          write(my_line, string'("In clock cycle: "));
          write(my_line, cycle_cnt);
          writeline(my_dump, my_line);
        end if;
        if (regWr) then
          write(my_line, string'("Register Write to Reg: 0x"));
          hwrite(my_line, regWrAddr);
          write(my_line, string'(" Val: 0x"));
          hwrite(my_line, regWrData);
          writeline(my_dump, my_line);
        end if;
        if (memWr) then
          write(my_line, string'("Memory Write to Addr: 0x"));
          hwrite(my_line, memAddr);
          write(my_line, string'(" Val: 0x"));
          hwrite(my_line, memData);
          writeline(my_dump, my_line);
		end if;
        cycle_cnt := cycle_cnt + 1;
		halt := '1' when (inst(31 downto 26) = "000000") and (inst(5 downto 0) = "001100") and (v0Val = "00000000000000000000000000001010") else '0';
		if (halt = '1') then
			write(my_line, string'("Execution is stopping!"));
			writeline(my_dump, my_line);
			stop(2);
		end if;
      end if;
  end process;

end mixed;
