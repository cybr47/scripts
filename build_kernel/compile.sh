#!/bin/bash

#######################MANUAL LOCAL BUILD##########################################
#####-------------------------CLEAN-----------------######
                    
                    
#rm -rf out/ && make clean && make mrproper




# export ARCH=arm64
# export SUBARCH=arm64
# export DTC_EXT=dtc
# export CLANG_TRIPLE=aarch64-linux-gnu-
# export CROSS_COMPILE=/home/raman047/kernel/proton-clang/cc64bit/bin/aarch64-linux-android-
# export CROSS_COMPILE_ARM32=/home/raman047/kernel/proton-clang/cc32bit/bin/arm-linux-androideabi-

# make O=out CC=clang CLANG_TRIPLE=/home/raman047/kernel/proton-clang/bin/aarch64-linux-gnu- vendor/violet-perf_defconfig

# make -j150 O=out CC=clang CLANG_TRIPLE=/home/raman047/kernel/proton-clang/bin/aarch64-linux-gnu-



######--------------------------------------PROTON CLANG--------------------------------------######

export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
export PATH="$HOME/kernel/proton-clang/bin:$PATH"

make O=out vendor/violet-perf_defconfig

make CC=clang \
                CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip LD=ld.lld\
                O=out \
                -j8




#############----------------------DTBO-----------------------------------------------------#######


git clone https://android.googlesource.com/platform/system/libufdt scripts/ufdt/libufdt

python2 scripts/ufdt/libufdt/utils/src/mkdtboimg.py create out/arch/arm64/boot/dtbo.img --page_size=4096 out/arch/arm64/boot/dts/qcom/sm6150-idp-overlay.dtbo


##############_______________COPY BUILD FILE_____________________________________#######

cp out/arch/arm64/boot/Image.gz-dtb /home/raman047/kernel/anykernel/Latest_build

cp out/arch/arm64/boot/dtbo.img /home/raman047/kernel/anykernel/Latest_build
