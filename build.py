"""Configure + build under the MSVC environment clang-cl needs."""
import subprocess, sys
sys.path.insert(0, r"G:\recomp\ps3\tools")
from msvc_env import environ
env = environ()
if not __import__("os").path.exists("build/build.ninja"):
    subprocess.run(["cmake", "-S", ".", "-B", "build", "-G", "Ninja",
                    "-DCMAKE_C_COMPILER=clang-cl", "-DCMAKE_CXX_COMPILER=clang-cl"], env=env, check=True)
sys.exit(subprocess.run(["cmake", "--build", "build"] + sys.argv[1:], env=env).returncode)
