#!/bin/bash

source util/travis_push.sh

if [[ "$TRAVIS_COMMIT_MESSAGE" != *"[skip docs]"* ]] ; then 
	if git diff --name-only ${TRAVIS_COMMIT_RANGE} | grep -e '^quantum/' -e '^tmk_core/' -e '^docs/api_.*'; then
		echo "Generating API docs..."
		rm -rf doxygen
		doxygen Doxyfile
		moxygen -a -g -o docs/api_%s.md doxygen/xml
		git add docs/api_*
		git commit -m'autogenerated api docs for ${TRAVIS_COMMIT_RANGE}'
	fi
fi
