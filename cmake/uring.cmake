MACRO(CHECK_URING)
  IF(CMAKE_SYSTEM_NAME MATCHES "Linux")
    INCLUDE(CheckIncludeFiles)
    SET(WITH_URING "auto" CACHE STRING "Enable liburing usage")
    IF(WITH_URING STREQUAL "yes" OR WITH_URING STREQUAL "auto")
      FIND_LIBRARY(LIBURING uring)
      CHECK_INCLUDE_FILES(liburing.h HAVE_LIBURING_H)
      IF (LIBURING AND HAVE_LIBURING_H)
	ADD_DEFINITIONS(-DHAVE_URING)
	LINK_LIBRARIES(uring)
      ELSE()
        IF(WITH_URING STREQUAL "yes")
          MESSAGE(FATAL_ERROR "Requested WITH_URING=yes but liburing was not found")
        ENDIF()
        UNSET(LIBURING CACHE)
        UNSET(HAVE_LIBURING_H CACHE)
      ENDIF()
    ELSEIF(WITH_URING STREQUAL "no")
      UNSET(LIBURING CACHE)
      UNSET(HAVE_LIBURING_H CACHE)
    ELSE()
      MESSAGE(FATAL_ERROR "Invalid value for WITH_URING. Must be 'yes', 'no', or 'auto'.")
    ENDIF()
  ENDIF()
ENDMACRO()
