################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(C++_DEPS)),)
-include $(C++_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
LSS += \
flicker_lamp.lss \

FLASH_IMAGE += \
flicker_lamp.hex \

EEPROM_IMAGE += \
flicker_lamp.eep \

SIZEDUMMY += \
sizedummy \


# All Target
all: flicker_lamp.elf secondary-outputs

# Tool invocations
flicker_lamp.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: AVR C++ Linker'
	avr-g++ -Wl,-Map,flicker_lamp.map,--cref -mrelax -Wl,--gc-sections -mmcu=attiny13 -o "flicker_lamp.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

flicker_lamp.lss: flicker_lamp.elf
	@echo 'Invoking: AVR Create Extended Listing'
	-avr-objdump -d -l flicker_lamp.elf  >"flicker_lamp.lss"
	@echo 'Finished building: $@'
	@echo ' '

flicker_lamp.hex: flicker_lamp.elf
	@echo 'Create Flash image (ihex format)'
	-avr-objcopy -R .eeprom -R .fuse -R .lock -R .signature -O ihex flicker_lamp.elf  "flicker_lamp.hex"
	@echo 'Finished building: $@'
	@echo ' '

flicker_lamp.eep: flicker_lamp.elf
	@echo 'Create eeprom image (ihex format)'
	-avr-objcopy -j .eeprom --no-change-warnings --change-section-lma .eeprom=0 -O ihex flicker_lamp.elf  "flicker_lamp.eep"
	@echo 'Finished building: $@'
	@echo ' '

sizedummy: flicker_lamp.elf
	@echo 'Invoking: Print Size'
	-avr-size --format=avr --mcu=attiny13 flicker_lamp.elf
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(C_UPPER_DEPS)$(S_DEPS)$(LSS)$(C_DEPS)$(FLASH_IMAGE)$(CC_DEPS)$(ELFS)$(C++_DEPS)$(OBJS)$(CXX_DEPS)$(ASM_DEPS)$(EEPROM_IMAGE)$(SIZEDUMMY)$(S_UPPER_DEPS)$(CPP_DEPS) flicker_lamp.elf
	-@echo ' '

secondary-outputs: $(LSS) $(FLASH_IMAGE) $(EEPROM_IMAGE) $(SIZEDUMMY)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
