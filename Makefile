SKILLS := $(notdir $(wildcard skills/*))

.PHONY: zip install clean

# Build one zip per skill (for upload to claude.ai or ChatGPT).
zip: $(SKILLS:%=dist/%.zip)

dist/%.zip: skills/%/SKILL.md
	@mkdir -p dist
	@rm -f $@
	cd skills && zip -qr ../$@ $*
	@echo $@

# Symlink every skill into Claude Code's and Codex's personal skill folders.
install:
	@for dir in $(HOME)/.claude/skills $(HOME)/.codex/skills; do \
		mkdir -p $$dir; \
		for s in $(SKILLS); do ln -sfn $(CURDIR)/skills/$$s $$dir/$$s; done; \
		echo "linked $(SKILLS) into $$dir"; \
	done

clean:
	rm -rf dist
