--!A cross-platform build utility based on Lua
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- 
-- Copyright (C) 2015 - 2019, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        xmakefile.lua
--

-- imports
import("core.project.project")

-- make build
function _make_build(makefile)
    makefile:print(".PHONY: build")
    makefile:print("")
    makefile:print("build: ")
    makefile:print("\t@xmake --build %$(VERBOSE) %$(TARGET)")
    makefile:print("")
end

-- make rebuild
function _make_rebuild(makefile)
    makefile:print("rebuild: ")
    makefile:print("\t@xmake --rebuild %$(VERBOSE) %$(TARGET)")
    makefile:print("")
end

-- make install
function _make_install(makefile)
    makefile:print("install: ")
    makefile:print("\t@xmake install %$(VERBOSE) %$(TARGET)")
    makefile:print("")
end

-- make uninstall
function _make_uninstall(makefile)
    makefile:print("uninstall: ")
    makefile:print("\t@xmake uninstall %$(VERBOSE) %$(TARGET)")
    makefile:print("")
end

-- make package
function _make_package(makefile)
    makefile:print("package: ")
    makefile:print("\t@xmake package %$(VERBOSE) %$(TARGET)")
    makefile:print("")
end

-- make clean
function _make_clean(makefile)
    makefile:print("clean: ")
    makefile:print("\t@xmake clean %$(VERBOSE) %$(TARGET)")
    makefile:print("")
end

-- make run
function _make_run(makefile)
    makefile:print("run: ")
    makefile:print("\t@xmake run %$(VERBOSE) %$(TARGET)")
    makefile:print("")
end

-- make debug
function _make_debug(makefile)
    makefile:print("debug: ")
    makefile:print("\t@xmake run -d %$(VERBOSE) %$(TARGET)")
    makefile:print("")
end

-- make config
function _make_config(makefile)
    makefile:print("ifneq (%$(PLAT),)")
    makefile:print("ifneq (%$(ARCH),)")
    makefile:print("ifneq (%$(MODE),)")
    makefile:print("CONFIG=xmake config -c %$(VERBOSE) -p %$(PLAT) -a %$(ARCH) -m %$(MODE) %$(TARGET)")
    makefile:print("else")
    makefile:print("CONFIG=xmake config -c %$(VERBOSE) -p %$(PLAT) -a %$(ARCH) %$(TARGET)")
    makefile:print("endif")
    makefile:print("else")
    makefile:print("CONFIG=xmake config -c %$(VERBOSE) -p %$(PLAT) %$(TARGET)")
    makefile:print("endif")
    makefile:print("else")
    makefile:print("CONFIG=xmake config -c %$(VERBOSE) %$(TARGET)")
    makefile:print("endif")
    makefile:print("config: ")
    makefile:print("\t@%$(CONFIG)")
    makefile:print("")
end

-- make
function make(outputdir)

    -- enter project directory
    local oldir = os.cd(os.projectdir())

    -- open the makefile
    local makefile = io.open(path.join(outputdir, "makefile"), "w")

    -- verbose?
    makefile:print("ifeq (%$(V),1)")
    makefile:print("VERBOSE=-v")
    makefile:print("else")
    makefile:print("VERBOSE=")
    makefile:print("endif")
    makefile:print("")

    -- make build
    _make_build(makefile)

    -- make rebuild
    _make_rebuild(makefile)
    
    -- make install
    _make_install(makefile)
 
    -- make uninstall
    _make_uninstall(makefile)
 
    -- make package
    _make_package(makefile)
    
    -- make clean 
    _make_clean(makefile)

    -- make run
    _make_run(makefile)

    -- make debug
    _make_debug(makefile)

    -- make config
    _make_config(makefile)
    
    -- close the makefile
    makefile:close()
 
    -- leave project directory
    os.cd(oldir)
end
