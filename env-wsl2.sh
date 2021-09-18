export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export PATH=$HOME/platform-tools:/usr/local/bin:$PATH
export PATH=/usr/lib/jvm/java-8-openjdk-amd64:/usr/local/sdat2img:$PATH
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
# This fixes locale related assertion with flex!
export LANG="en_DE.UTF-8"
