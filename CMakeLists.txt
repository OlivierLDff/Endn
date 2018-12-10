#
#	LibEndian CMake script by Olivier Le Doeuff

#
## CMAKE INPUT
#
#	- LIBENDIAN_TARGET : Name of the library target. Default : "LibEndian"
#	- LIBENDIAN_PROJECT : Name of the project. Default : "LibEndian"
#	- LIBENDIAN_BUILD_SHARED : Build shared library [ON OFF]. Default: OFF.
#	- LIBENDIAN_BUILD_STATIC : Build static library [ON OFF]. Default: ON.
#	- LIBENDIAN_USE_NAMESPACE : If the library compile with a namespace [ON OFF]. Default: OFF.
#	- LIBENDIAN_NAMESPACE : Namespace for the library. Only relevant if LIBENDIAN_USE_NAMESPACE is ON. Default: "Endn".
#	- LIBENDIAN_BUILD_DOC : Build the LibEndian Doc [ON OFF]. Default: OFF.
#	- LIBENDIAN_DOXYGEN_BT_REPOSITORY : Repository of DoxygenBt. Default : "https://github.com/OlivierLDff/DoxygenBootstrapped.git"
#	- LIBENDIAN_DOXYGEN_BT_TAG : Git Tag of DoxygenBt. Default : "v1.3.1"

#
## CMAKE OUTPUT
#
#	- LIBENDIAN_TARGET : Output target to link to. Default: LibEndian
#	- LIBENDIAN_VERSION : Current version of the library
#

#
## VERSION
#	- 1.0.0 : 06/12/2018 : Initial Work

# ┌──────────────────────────────────────────────────────────────────┐
# │						  CMAKE PROPERTIES							 │
# └──────────────────────────────────────────────────────────────────┘

CMAKE_MINIMUM_REQUIRED( VERSION 3.1.0 )

# ┌──────────────────────────────────────────────────────────────────┐
# │						  PROJECT SETTINGS							 │
# └──────────────────────────────────────────────────────────────────┘

SET( LIBENDIAN_TARGET "LibEndian" CACHE STRING "Target Name" )
SET( LIBENDIAN_PROJECT "LibEndian" CACHE STRING "Project Name")
SET( LIBENDIAN_BUILD_SHARED OFF CACHE BOOL "Build shared lib for LibEndian" )
IF(NOT LIBENDIAN_BUILD_SHARED)
SET( LIBENDIAN_BUILD_STATIC ON CACHE BOOL "Build static lib for LibEndian" )
ELSE(NOT LIBENDIAN_BUILD_SHARED)
SET( LIBENDIAN_BUILD_STATIC OFF CACHE BOOL "Build static lib for LibEndian" )
ENDIF(NOT LIBENDIAN_BUILD_SHARED)
SET( LIBENDIAN_USE_NAMESPACE OFF CACHE BOOL "If the library compile with a namespace.")
SET( LIBENDIAN_NAMESPACE "Endn" CACHE STRING "Namespace for the library. Only relevant if LIBENDIAN_USE_NAMESPACE is ON")
SET( LIBENDIAN_BUILD_DOC OFF CACHE BOOL "Build LibEndian Doc with Doxygen" )
SET( LIBENDIAN_DOXYGEN_BT_REPOSITORY "https://github.com/OlivierLDff/DoxygenBootstrappedCMake.git" CACHE STRING "Repository of DoxygenBt" )
SET( LIBENDIAN_DOXYGEN_BT_TAG v1.3.1 CACHE STRING "Git Tag of DoxygenBt" )

PROJECT( ${LIBENDIAN_PROJECT} C CXX )
SET_PROPERTY(GLOBAL PROPERTY USE_FOLDERS ON)

# ┌──────────────────────────────────────────────────────────────────┐
# │						  VERSION 	 								 │
# └──────────────────────────────────────────────────────────────────┘

# Project version must be set here
SET(LIBENDIAN_VERSION_MAJOR 1)
SET(LIBENDIAN_VERSION_MINOR 0)
SET(LIBENDIAN_VERSION_PATCH 1)
SET(LIBENDIAN_VERSION ${LIBENDIAN_VERSION_MAJOR}.${LIBENDIAN_VERSION_MINOR}.${LIBENDIAN_VERSION_PATCH} CACHE STRING "LibEndian Version")

IF( EXISTS "${CMAKE_SOURCE_DIR}/.git" )
	EXECUTE_PROCESS(
		COMMAND git describe --always
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
		OUTPUT_VARIABLE LIBENDIAN_VERSION_TAG
		OUTPUT_STRIP_TRAILING_WHITESPACE
	)
ELSE()
	SET( LIBENDIAN_VERSION_TAG 00000000 )
ENDIF()
SET( LIBENDIAN_VERSION_TAG_HEX 0x${LIBENDIAN_VERSION_TAG})

# ┌──────────────────────────────────────────────────────────────────┐
# │						  STATUS 	 								 │
# └──────────────────────────────────────────────────────────────────┘

MESSAGE( STATUS  "------ ${LIBENDIAN_TARGET} Configuration ${LIBENDIAN_VERSION} ------" )

MESSAGE( STATUS "LIBENDIAN_TARGET                 : ${LIBENDIAN_TARGET}" )
MESSAGE( STATUS "LIBENDIAN_PROJECT                : ${LIBENDIAN_PROJECT}" )
MESSAGE( STATUS "LIBENDIAN_VERSION                : ${LIBENDIAN_VERSION_MAJOR}.${LIBENDIAN_VERSION_MINOR}.${LIBENDIAN_VERSION_PATCH}" )
MESSAGE( STATUS "LIBENDIAN_VERSION_TAG_HEX        : ${LIBENDIAN_VERSION_TAG_HEX}" )
MESSAGE( STATUS "LIBENDIAN_BUILD_SHARED           : ${LIBENDIAN_BUILD_SHARED}" )
MESSAGE( STATUS "LIBENDIAN_BUILD_STATIC           : ${LIBENDIAN_BUILD_STATIC}" )
MESSAGE( STATUS "LIBENDIAN_USE_NAMESPACE          : ${LIBENDIAN_USE_NAMESPACE}" )
IF(LIBENDIAN_USE_NAMESPACE)
MESSAGE( STATUS "LIBENDIAN_NAMESPACE              : ${LIBENDIAN_NAMESPACE}" )
ENDIF(LIBENDIAN_USE_NAMESPACE)
MESSAGE( STATUS "LIBENDIAN_BUILD_DOC              : ${LIBENDIAN_BUILD_DOC}" )
IF(LIBENDIAN_BUILD_DOC)
MESSAGE( STATUS "LIBENDIAN_DOXYGEN_BT_REPOSITORY  : ${LIBENDIAN_DOXYGEN_BT_REPOSITORY}" )
MESSAGE( STATUS "LIBENDIAN_DOXYGEN_BT_TAG         : ${LIBENDIAN_DOXYGEN_BT_TAG}" )
ENDIF(LIBENDIAN_BUILD_DOC)

MESSAGE( STATUS "------ ${LIBENDIAN_TARGET} End Configuration ------" )

IF((LIBENDIAN_BUILD_SHARED AND LIBENDIAN_BUILD_STATIC) OR (NOT LIBENDIAN_BUILD_SHARED AND NOT LIBENDIAN_BUILD_STATIC))
MESSAGE( FATAL_ERROR "Set either Build shared or build static to ON, can't build both at once" )
ENDIF((LIBENDIAN_BUILD_SHARED AND LIBENDIAN_BUILD_STATIC) OR (NOT LIBENDIAN_BUILD_SHARED AND NOT LIBENDIAN_BUILD_STATIC))

# ┌──────────────────────────────────────────────────────────────────┐
# │						  SOURCES 	 								 │
# └──────────────────────────────────────────────────────────────────┘

SET( LIBENDIAN_SRCS 
	# Main
	${CMAKE_CURRENT_SOURCE_DIR}/src/LibEndian.hpp
	${CMAKE_CURRENT_SOURCE_DIR}/src/LittleEndian.hpp
	${CMAKE_CURRENT_SOURCE_DIR}/src/LittleEndian.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/src/BigEndian.hpp
	${CMAKE_CURRENT_SOURCE_DIR}/src/BigEndian.cpp
	)

# ┌──────────────────────────────────────────────────────────────────┐
# │						  TARGET 	 								 │
# └──────────────────────────────────────────────────────────────────┘

IF(LIBENDIAN_BUILD_SHARED)
	IF( MSVC )
	INCLUDE (GenerateExportHeader)
	ENDIF( MSVC )

	ADD_LIBRARY( ${LIBENDIAN_TARGET} SHARED ${LIBENDIAN_SRCS} )

	IF( MSVC )
	GENERATE_EXPORT_HEADER( ${LIBENDIAN_TARGET}
		BASE_NAME ${LIBENDIAN_TARGET}
		EXPORT_MACRO_NAME ${LIBENDIAN_TARGET}_EXPORT
		EXPORT_FILE_NAME ${LIBENDIAN_TARGET}_Export.h
		STATIC_DEFINE ${LIBENDIAN_TARGET}_BUILT_AS_STATIC
	)
	ENDIF( MSVC )
	
	TARGET_COMPILE_DEFINITIONS( ${LIBENDIAN_TARGET} PRIVATE -DLIBENDIAN_SHARED )

ELSE()
	ADD_LIBRARY( ${LIBENDIAN_TARGET} STATIC ${LIBENDIAN_SRCS} )
	TARGET_COMPILE_DEFINITIONS( ${LIBENDIAN_TARGET} PUBLIC -DLIBENDIAN_STATIC )
ENDIF()

TARGET_INCLUDE_DIRECTORIES( ${LIBENDIAN_TARGET} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src )
TARGET_COMPILE_DEFINITIONS( ${LIBENDIAN_TARGET} PRIVATE -DLIBENDIAN_VERSION_MAJOR=${LIBENDIAN_VERSION_MAJOR} )
TARGET_COMPILE_DEFINITIONS( ${LIBENDIAN_TARGET} PRIVATE -DLIBENDIAN_VERSION_MINOR=${LIBENDIAN_VERSION_MINOR} )
TARGET_COMPILE_DEFINITIONS( ${LIBENDIAN_TARGET} PRIVATE -DLIBENDIAN_VERSION_PATCH=${LIBENDIAN_VERSION_PATCH} )
TARGET_COMPILE_DEFINITIONS( ${LIBENDIAN_TARGET} PRIVATE -DLIBENDIAN_VERSION_TAG=${LIBENDIAN_VERSION_TAG} )
TARGET_COMPILE_DEFINITIONS( ${LIBENDIAN_TARGET} PRIVATE -DLIBENDIAN_VERSION_TAG_HEX=${LIBENDIAN_VERSION_TAG_HEX} )
IF(LIBENDIAN_USE_NAMESPACE)
TARGET_COMPILE_DEFINITIONS( ${LIBENDIAN_TARGET} PUBLIC -DLIBENDIAN_USE_NAMESPACE )
TARGET_COMPILE_DEFINITIONS( ${LIBENDIAN_TARGET} PUBLIC -DLIBENDIAN_NAMESPACE=${LIBENDIAN_NAMESPACE} )
ENDIF(LIBENDIAN_USE_NAMESPACE)

# ┌──────────────────────────────────────────────────────────────────┐
# │						  DOXYGEN 									 │
# └──────────────────────────────────────────────────────────────────┘

IF(LIBENDIAN_BUILD_DOC)
SET( DOXYGEN_BOOTSTRAP_COMPANY OlivierLDff )
SET( DOXYGEN_BOOTSTRAP_PUBLISHER OlivierLDff )
SET( DOXYGEN_BOOTSTRAP_PROJECT_NAME ${LIBENDIAN_TARGET} )
SET( DOXYGEN_BOOTSTRAP_PROJECT_VERSION ${LIBENDIAN_VERSION_MAJOR}.${LIBENDIAN_VERSION_MINOR}.${LIBENDIAN_VERSION_PATCH} )
SET( DOXYGEN_BOOTSTRAP_PROJECT_BRIEF "A cross platform C++ library to get rid with of binary serialization issues." )
SET( DOXYGEN_BOOTSTRAP_PROJECT_LOGO )
SET( DOXYGEN_BOOTSTRAP_OUTPUT_DIRECTORY "Docs" )
SET( DOXYGEN_BOOTSTRAP_SRC_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/src )
SET( DOXYGEN_BOOTSTRAP_README ${CMAKE_CURRENT_SOURCE_DIR}/README.md )
SET( DOXYGEN_TARGET_PREFIX "" )
SET( DOXYGEN_TARGET_SUFFIX "Doc" )
SET( DOXYGEN_BT_REPOSITORY ${LIBENDIAN_DOXYGEN_BT_REPOSITORY} )
SET( DOXYGEN_BT_TAG ${LIBENDIAN_DOXYGEN_BT_TAG} )
INCLUDE(${CMAKE_CURRENT_SOURCE_DIR}/cmake/BuildDoxygenBt.cmake)
ENDIF(LIBENDIAN_BUILD_DOC)