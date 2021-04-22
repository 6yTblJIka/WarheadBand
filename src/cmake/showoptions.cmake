#
# This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# User has manually chosen to ignore the git-tests, so throw them a warning.
# This is done EACH compile so they can be alerted about the consequences.
#

# output generic information about the core and buildtype chosen
message("")
message("* WarheadCore revision            : ${rev_hash} ${rev_date} (${rev_branch} branch)")
if( UNIX )
  message("* WarheadCore buildtype           : ${CMAKE_BUILD_TYPE}")
endif()
message("")

# output information about installation-directories and locations

message("* Install core to                 : ${CMAKE_INSTALL_PREFIX}")
if( UNIX )
  message("* Install libraries to            : ${LIBSDIR}")
endif()

message("* Install configs to              : ${CONF_DIR}")
add_definitions(-D_CONF_DIR=$<1:"${CONF_DIR}">)

message("")

# Show infomation about the options selected during configuration

if( SERVERS )
  message("* Build world/auth                : Yes (default)")
else()
  message("* Build world/authserver          : No")
endif()

if(SCRIPTS AND (NOT SCRIPTS STREQUAL "none"))
  message("* Build with scripts              : Yes (${SCRIPTS})")
else()
  message("* Build with scripts              : No")
endif()

if( TOOLS )
  message("* Build map/vmap tools            : Yes")
  add_definitions(-DNO_CORE_FUNCS)
else()
  message("* Build map/vmap tools            : No  (default)")
endif()

if( BUILD_TESTING )
  message("* Build unit tests                : Yes")
else()
  message("* Build unit tests                : No  (default)")
endif()

if( USE_COREPCH )
  message("* Build core w/PCH                : Yes (default)")
else()
  message("* Build core w/PCH                : No")
endif()

if( USE_SCRIPTPCH )
  message("* Build scripts w/PCH             : Yes (default)")
else()
  message("* Build scripts w/PCH             : No")
endif()

if( WITH_WARNINGS )
  message("* Show all warnings               : Yes")
else()
  message("* Show compile-warnings           : No  (default)")
endif()

if( WITH_COREDEBUG )
  message("* Use coreside debug              : Yes")
  add_definitions(-DACORE_DEBUG)
else()
  message("* Use coreside debug              : No  (default)")
endif()

if ( UNIX )
  if( WITH_PERFTOOLS )
    message("* Use unix gperftools             : Yes")
    add_definitions(-DPERF_TOOLS)
  else()
    message("* Use unix gperftools             : No  (default)")
  endif()
endif( UNIX )

if( WIN32 )
  if( USE_MYSQL_SOURCES )
  message("* Use MySQL sourcetree            : Yes (default)")
  else()
  message("* Use MySQL sourcetree            : No")
  endif()
endif( WIN32 )

if ( WITHOUT_GIT )
  message("* Use GIT revision hash           : No")
  message("")
  message(" *** WITHOUT_GIT - WARNING!")
  message(" *** By choosing the WITHOUT_GIT option you have waived all rights for support,")
  message(" *** and accept that or all requests for support or assistance sent to the core")
  message(" *** developers will be rejected. This due to that we will be unable to detect")
  message(" *** what revision of the codebase you are using in a proper way.")
  message(" *** We remind you that you need to use the repository codebase and a supported")
  message(" *** version of git for the revision-hash to work, and be allowede to ask for")
  message(" *** support if needed.")
else()
  message("* Use GIT revision hash           : Yes (default)")
endif()

if ( NOJEM )
  message("")
  message(" *** NOJEM - WARNING!")
  message(" *** jemalloc linking has been disabled!")
  message(" *** Please note that this is for DEBUGGING WITH VALGRIND only!")
  message(" *** DO NOT DISABLE IT UNLESS YOU KNOW WHAT YOU'RE DOING!")
endif()

# Performance optimization options:

if( ENABLE_EXTRAS )
  message("* Enable extra features           : Yes (default)")
  add_definitions(-DENABLE_EXTRAS)
else()
  message("* Enable extra features           : No")
endif()

if( ENABLE_VMAP_CHECKS )
  message("* Enable vmap DisableMgr checks   : Yes (default)")
  add_definitions(-DENABLE_VMAP_CHECKS)
else()
  message("* Enable vmap DisableMgr checks   : No")
endif()

if( ENABLE_EXTRA_LOGS )
  message("* Enable extra logging functions  : Yes")
  add_definitions(-DENABLE_EXTRA_LOGS)
else()
  message("* Enable extra logging functions  : No (default)")
endif()

if(WIN32)
  if(NOT WITH_SOURCE_TREE STREQUAL "no")
  message("* Show source tree                : Yes - \"${WITH_SOURCE_TREE}\"")
  else()
  message("* Show source tree                : No")
  endif()
else()
  message("* Show source tree                : No (For UNIX default)")
endif()

if(BUILD_SHARED_LIBS)
  message("")
  message(" *** WITH_DYNAMIC_LINKING - INFO!")
  message(" *** Will link against shared libraries!")
  message(" *** Please note that this is an experimental feature!")
  if(WITH_DYNAMIC_LINKING_FORCED)
    message("")
    message(" *** Dynamic linking was enforced through a dynamic script module!")
  endif()
  add_definitions(-DWARHEAD_API_USE_DYNAMIC_LINKING)

  WarnAboutSpacesInBuildPath()
endif()

message("")
