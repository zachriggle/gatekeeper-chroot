#!/usr/bin/env bats

setup() {
    export PATH="$BATS_TEST_DIRNAME:$PATH"
}

@test "${BATS_TEST_DIRNAME##*/} starts at /" {
    uname -s | grep Darwin && skip
    run chroot-full $(mktemp -d) sh -c 'echo "XX$(pwd)XX"'
    [[ "$output" =~ "/" ]]
}

@test "${BATS_TEST_DIRNAME##*/} cannot setuid root" {
    uname -s | grep Darwin && skip
    run chroot-full $(mktemp -d) sudo id
    [[ "$output" =~ "setuid" ]]
}

@test "${BATS_TEST_DIRNAME##*/} empty chroot works /" {
    uname -s | grep Darwin && skip
    run chroot-empty empty-chroot sh -c 'echo "Hello"'
    [[ "$output" =~ "Hello" ]]

    run chroot-empty empty-chroot sh -c 'echo */*'
    [[ "$output" =~ "bin/sh lib/x86_64-linux-gnu lib64/ld-linux-x86-64.so.2" ]]
}
