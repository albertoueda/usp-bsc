TARGET_DIR=../pdfs
MAKECOMMAND=$(MAKE) BINARY_TARGET_DIR=$(TARGET_DIR) 


all:
	cd apresentacao && $(MAKECOMMAND) 
	cd poster && $(MAKECOMMAND) 
	cd monografia && $(MAKECOMMAND)


clean:
	cd apresentacao && make clean
	cd poster && make clean
	cd monografia && make clean
