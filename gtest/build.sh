# Usage: Prog version
version=$1
version=${version:="1.7.0"}

CURRNET_PATH=`pwd`

branch_name=release-$version

target_path=${CURRNET_PATH}/${version}

if ! test -e ${target_path}/repo; then
    git clone -b $branch_name https://github.com/google/googletest ${target_path}/repo
fi

if ! test -e ${target_path}/include; then 
    cp -r ${target_path}/repo/include ${target_path}/include
fi

if ! test -e ${target_path}/lib; then 
    mkdir -p ${target_path}/tmp_build
    (cd ${target_path}/tmp_build && cmake ../repo && make)
    mkdir ${target_path}/lib
    cp ${target_path}/tmp_build/*.a ${target_path}/lib
    rm -rf ${target_path}/tmp_build
fi

exit 0
