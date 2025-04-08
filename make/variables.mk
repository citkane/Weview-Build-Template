#
# MIT License
#
# Copyright (c) 2025 Michael Jonker
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

SYSTEM_PROJECT_NAME := $(call to_lower_snake, "${USER_PROJECT_NAME}")
WV_ROOT_DIR = ${ROOT_DIR}${WEBVIEW_REL_ROOT}


COMPILED_M := with C++ COMPILED Webview
STATIC_M := with C++ STATIC linked lib
SHARED_M := with C++ SHARED linked lib
TARGETED_M := with C++ TARGETED linked webview::core
TARGETED_STATIC_M := with C TARGETED linked webview::core_static
TARGETED_SHARED_M := with C TARGETED linked webview::core_shared
SUCCESS_M := Success!

COMMON_DEFS := -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
-DWV_ROOT_DIR=${WV_ROOT_DIR} \
-DUSER_PROJECT_NAME="${USER_PROJECT_NAME}" \
-DSYSTEM_PROJECT_NAME=${SYSTEM_PROJECT_NAME}

WV_COMMON_DEFS := -DWEBVIEW_ENABLE_CLANG_FORMAT=FALSE \
-DWEBVIEW_ENABLE_CLANG_TIDY=FALSE \
-DWEBVIEW_BUILD_EXAMPLES=FALSE \
-DWEBVIEW_BUILD_TESTS=FALSE \
-DWEBVIEW_BUILD_DOCS=FALSE \
-DWEBVIEW_BUILD_AMALGAMATION=FALSE \
-DWEBVIEW_BUILD_SHARED_LIBRARY=TRUE \
-DWEBVIEW_BUILD_STATIC_LIBRARY=TRUE

ifeq ($(OS),Windows_NT)
	WV_BUILD_DIR := ${WV_ROOT_DIR}/build-win-mingw
	BUILD_DIR_COMPILED := build-win-compiled
	BUILD_DIR_STATIC := build-win-static
	BUILD_DIR_SHARED := build-win-shared
	BUILD_DIR_TARGETED := build-win-targeted

	MSVC_WV_BUILD_DIR := ${WV_ROOT_DIR}/build-win-msvc
	MSVC_BUILD_DIR_COMPILED := build-msvc-compiled
	MSVC_BUILD_DIR_STATIC := build-msvc-static
	MSVC_BUILD_DIR_SHARED := build-msvc-shared
	MSVC_BUILD_DIR_TARGETED := build-msvc-targeted

	DEFS := ${COMMON_DEFS}

else ifeq ($(UNAME),Linux)
	WV_BUILD_DIR := ${WV_ROOT_DIR}/build-linux-llvm
	BUILD_DIR_COMPILED := build-linux-compiled
	BUILD_DIR_STATIC := build-linux-static
	BUILD_DIR_SHARED := build-linux-shared
	BUILD_DIR_TARGETED := build-linux-targeted
	BUILD_DIR_TARGETED_STATIC := build-linux-targeted-static
	BUILD_DIR_TARGETED_SHARED := build-linux-targeted-shared

	DEFS := ${COMMON_DEFS} -DWEBKITGTK_V=${WEBKITGTK_V} -DWV_BUILD_DIR=${WV_BUILD_DIR}

else ifeq ($(UNAME),Darwin)
	WV_BUILD_DIR := ${WV_ROOT_DIR}/build-mac-appleclang
	BUILD_DIR_COMPILED := build-mac-compiled
	BUILD_DIR_STATIC := build-mac-static
	BUILD_DIR_SHARED := build-mac-shared
	BUILD_DIR_TARGETED := build-mac-targeted

	DEFS := ${COMMON_DEFS} -DWV_BUILD_DIR=${WV_BUILD_DIR}

endif

BUILD_DIRS := ${WV_BUILD_DIR} ${BUILD_DIR_COMPILED} ${BUILD_DIR_STATIC} ${BUILD_DIR_SHARED} ${BUILD_DIR_TARGETED} ${BUILD_DIR_TARGETED_STATIC} ${BUILD_DIR_TARGETED_SHARED}

ifeq ($(OS),Windows_NT)
	BUILD_DIRS := ${BUILD_DIRS} \
	${MSVC_WV_BUILD_DIR} ${MSVC_BUILD_DIR_COMPILED} ${MSVC_BUILD_DIR_STATIC} ${MSVC_BUILD_DIR_SHARED} ${MSVC_BUILD_DIR_TARGETED} ${MSVC_BUILD_DIR_TARGETED_STATIC} ${MSVC_BUILD_DIR_TARGETED_SHARED}
endif
