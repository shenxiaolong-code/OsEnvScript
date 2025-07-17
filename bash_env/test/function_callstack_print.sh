
# https://stackoverflow.com/questions/35006457/choosing-between-0-and-bash-source

function func1()
{
    func2
}

function func2()
{
    func3
}

function func3()
{
    # echo "${FUNCNAME}"
    echo "this function : ${FUNCNAME[0]}"
    echo "caller function : ${FUNCNAME[1]}"
    echo "FUNCNAME[2] : ${FUNCNAME[2]}"
    echo "FUNCNAME[3] : ${FUNCNAME[3]}"
}

func2

function test_inner_embed_function() {
  function test_func_inner() {
    echo "  test_func_inner"
    echo "  param_in_parent_func: ${param_in_parent_func}"
  }

  local param_in_parent_func="outer_param"
  echo "before test_inner_embed_function"
  test_func_inner
  echo "after test_inner_embed_function"
}

test_inner_embed_function