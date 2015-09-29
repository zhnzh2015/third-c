version=$1
version=${version:="1.59.0"}

CURRNET_PATH=`pwd`

target_path=${CURRNET_PATH}/${version}

if ! test -e ${target_path}; then
    mkdir -p ${target_path}

    remote_path="http://jaist.dl.sourceforge.net/project/boost/boost"
    tar_gz_fname=`curl -s ${remote_path}/${version}/ | grep "tar.gz" | sed 's/\(.*\)"\(boost_.*\.tar\.gz\)"\(.*\)/\2/g'`
    curl -# ${remote_path}/${version}/${tar_gz_fname} -O

    tar -xzvf ${tar_gz_fname} -C ${target_path}
    src_path=`echo ${tar_gz_fname} | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1/g'`
    mv ${target_path}/$src_path ${target_path}/repo
    mv ${tar_gz_fname} ${target_path}
fi

cd ${target_path}/repo
./bootstrap.sh --prefix=${target_path}
./b2 install

mkdir -p ${target_path}/lib/dylib
mv ${target_path}/lib/*.dylib ${target_path}/lib/dylib

