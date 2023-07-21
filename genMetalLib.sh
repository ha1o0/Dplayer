targetPath="./Dplayer/Classes/Utils/HDR"
metalPath="${targetPath}/HDR.ci.metal"
metalAirPath="${targetPath}/HDR.ci.air"
#metalLibPath="${TARGET_BUILD_DIR}/Dplayer.bundle/HDR.ci.metallib"
metalLibPath="${targetPath}/HDR.ci.metallib"
#xcrun metal -fcikernel ${metalPath} -c -o ${metalAirPath}
#xcrun metallib -cikernel -o ${metalLibPath} ${metalAirPath}
xcrun metal -c -fcikernel ${metalPath} -o ${metalAirPath}
xcrun metallib -cikernel ${metalAirPath} -o ${metalLibPath}
#xcrun -sdk macosx metal -c ${metalPath} -o ${metalAirPath}
#xcrun -sdk macosx metallib ${metalAirPath} -o ${metalLibPath}

