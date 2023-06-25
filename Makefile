project = .
name = HelveticaStandard
love = /mnt/c/Program\ Files\ \(x86\)/LOVE/
fullname = $(project)/build/$(name)

all: windows

windows: clean_windows $(fullname).love
	mkdir -p $(project)/build/windows
	cp -r $(love)/*.dll $(project)/build/windows/
	cp -r $(love)/license.txt $(project)/build/windows/
	cat $(love)/love.exe $(fullname).love > $(project)/build/windows/$(name).exe

$(fullname).love: clean_love
	mkdir -p $(project)/build
	cd $(project) && zip -9 -r build/$(name).love . \
		-x Makefile \
		-x build/**\* \
		-x build/ \
		-x .git/**\* \
		-x .git/ \
		-x .vscode/**\* \
		-x .vscode/ \
		-x .gitignore

deploy: deploy_windows

deploy_windows: windows
	cd $(project)/build/windows && zip -9 -r $(name).zip .

clean: clean_windows clean_love

clean_windows:
	rm -rf $(project)/build/windows

clean_love:
	rm -rf $(project)/build/$(name).love

.PHONY: clean windows all
