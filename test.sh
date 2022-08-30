#!/usr/bin/bash

set -xe
export WEBWATCH_DEST=$(realpath test/)

echo
echo "Test test pass"
rm -rf test/status
echo "prev logs" > test/log
env WEBWATCH_CONFIG=$(realpath test/pass.config) ./webwatch
if [ ! -f test/status ]; then
    echo "Status file not generated"
    false
fi
if ! grep -i "ok" test/status ; then
    echo "ok status should be reported"
    false
fi
if ! grep "prev logs" test/log ; then
    echo "old logs were removed"
    false
fi
if ! grep "google.com" test/log | grep -i "success" ; then
    echo "success were not logged"
    false
fi

echo
echo "Test failure connection refused"
rm -rf test/status test/log
TMP_FAILURE_CONFIG=/tmp/failure.config
cat test/failure.config | awk '{gsub("%RANDOM%", "'$(pwgen)'")}1' > $TMP_FAILURE_CONFIG
env WEBWATCH_CONFIG=$TMP_FAILURE_CONFIG ./webwatch
if [ ! -f test/status ]; then
    echo "Status file not generated"
    false
fi
if grep -i "ok" test/status ; then
    echo "ok status reported"
    false
fi
if ! grep -i "fail" test/status ; then
    echo "failure status not reported"
    false
fi
if ! grep -E "(refused|resolve)" test/status; then
    echo "'connection refused' or 'name not resolved' should be reported"
    false
fi
if ! grep "asdf" test/log | grep -i "fail" ; then
    echo "failure were not logged"
    false
fi

echo
echo "Test failure server responds 404"
rm -rf test/status
env WEBWATCH_CONFIG=$(realpath test/errorcode.config) ./webwatch
if [ ! -f test/status ]; then
    echo "Status file not generated"
    false
fi
if grep -i "ok" test/status ; then
    echo "ok status reported"
    false
fi
if ! grep -i "fail" test/status ; then
    echo "failure status not reported"
    false
fi
if ! grep -i "404" test/status; then
    echo "error code 404 should be reported"
    false
fi

echo
echo "Test create the output directory"
rm -rf test/output
export WEBWATCH_DEST=$(realpath test/output)
env WEBWATCH_CONFIG=$(realpath test/pass.config) ./webwatch
if [ ! -d test/output ]; then
    echo "output directory is not created"
    false
fi

echo
echo "All tests OK"

