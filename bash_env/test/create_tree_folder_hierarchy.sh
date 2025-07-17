

mkdir -p ${TEMP_DIR}/to_del/demo_dialect/{demo_mlir,include/demo,lib/Dialect/Demo,test}

touch ${TEMP_DIR}/to_del/demo_dialect/{include/demo/DemoOps.td,lib/Dialect/Demo/{CMakeLists.txt,DemoOps.cpp},test/{lit.cfg.py,ops.mlir},build_and_test_debug.sh}

cd ${TEMP_DIR}/to_del/demo_dialect/demo_mlir

touch {CMakeLists.txt,demo.td,demo_opt.cpp,test.mlir,build.sh}


tree ${TEMP_DIR}/to_del/demo_dialect