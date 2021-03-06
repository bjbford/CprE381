-- Quartus Prime VHDL Template
-- Single-port RAM with single read/write address

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instructMem is
	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);
	
	port 
	(
		addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end instructMem;

architecture rtl of instructMem is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

	-- Declare the RAM signal and specify a default value.	Quartus Prime
	-- will load the provided memory initialization file (.mif).
	signal ram : memory_t;
	attribute ram_init_file : string; -- newly added
	attribute ram_init_file of ram : signal is "dmem.mif"; -- newly added
	
begin

	--if(we = '1') then
		--ram(addr) <= data;
	--end if;
	ram(addr) <= ram(addr);
	q <= ram(addr);
end rtl;