PYTHON = python3

# needs kivy installed or in PYTHONPATH

.PHONY: theming apk clean

theming:
	$(PYTHON) -m kivy.atlas theming/light 1024 theming/light/*.png
prepare:
	# running pre build setup
	@cp tools/buildozer.spec ../../../buildozer.spec
	# copy electrumfairchains to main.py
	@cp ../../../run_efc ../../../main.py
	@-if [ ! -d "../../../.buildozer" ];then \
		cd ../../..; buildozer android debug;\
		cp -f electrumfairchains/gui/kivy/tools/blacklist.txt .buildozer/android/platform/python-for-android/src/blacklist.txt;\
		rm -rf ./.buildozer/android/platform/python-for-android/dist;\
	fi
apk:
	@make prepare
	@-cd ../../..; buildozer android debug deploy run
	@make clean
release:
	@make prepare
	@-cd ../../..; buildozer android release
	@make clean
clean:
	# Cleaning up
	# rename main.py to electrumfairchains
	@-rm ../../../main.py
	# remove buildozer.spec
	@-rm ../../../buildozer.spec
