.PHONY: docs dependency

docs:
	cd docs && doxygen

dependency:
	cd build && cmake .. --graphviz=graph.dot && dot -Tpng graph.dot -o graphImage.png