include(FetchContent)

set(GTEST_REPOSITORY "https://github.com/OlivierLDff/googletest" CACHE STRING "googletest repository url")
set(GTEST_TAG "release-1.12.1" CACHE STRING "googletest git tag")

FetchContent_Declare(
  googletest
  GIT_REPOSITORY ${GTEST_REPOSITORY}
  GIT_TAG        ${GTEST_TAG}
)

set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

set_target_properties(gtest gtest_main gmock gmock_main PROPERTIES FOLDER "Dependencies/gtest")
