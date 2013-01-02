TARGET_DIR=../site/pdfs
MAKECOMMAND=$(MAKE) BINARY_TARGET_DIR=$(TARGET_DIR) 


all:
	# cd apresentacao && $(MAKECOMMAND) 
	# cd poster && $(MAKECOMMAND) 
	cd monografia && $(MAKECOMMAND)
	cd site && ruby main.rb

clean:
	cd apresentacao && make clean
	cd poster && make clean
	cd monografia && make clean
	# cd site && rm -f *.html
