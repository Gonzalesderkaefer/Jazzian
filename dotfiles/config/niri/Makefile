
# customized KDL files
kdlfiles := $(shell find ./customized -type f -name '*.kdl')

# Default configuration
defkdl := def_config.kdl

config.kdl: $(kdlfiles)
	@echo "Throwing config togehter"
	@cat $(defkdl) > $@
	@cat $^ >> $@
