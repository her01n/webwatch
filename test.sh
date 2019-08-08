#!/usr/bin/bash

set -xe
export WEBWATCH_DEST=$(realpath test/)

echo
echo "Test test pass"
rm -rf test/status
env WEBWATCH_CONFIG=$(realpath test/pass/) ./webwatch
if [ ! -f test/status ]; then
    echo "Status file not generated"
    false
fi
if ! grep -i "ok" test/status ; then
    echo "ok status should be reported"
    false
fi

echo
echo "Test failure connection refused"
rm -rf test/status
env WEBWATCH_CONFIG=$(realpath test/failure/) ./webwatch
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
if ! grep -i "refused" test/status; then
    echo "connection refused should be reported"
    false
fi

echo
echo "Test failure server responds 404"
rm -rf test/status
env WEBWATCH_CONFIG=$(realpath test/errorcode/) ./webwatch
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
echo "All tests OK"

