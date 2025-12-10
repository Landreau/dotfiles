local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Snippets pour C++
ls.add_snippets("cpp", {
  -- #include <iostream>
  s("iostream", {
    t('#include <iostream>'),
  }),
  
  -- #include <vector>
  s("vector", {
    t('#include <vector>'),
  }),
  
  -- #include <string>
  s("string", {
    t('#include <string>'),
  }),
  
  -- #include <algorithm>
  s("algo", {
    t('#include <algorithm>'),
  }),
  
  -- #include <map>
  s("map", {
    t('#include <map>'),
  }),
  
  -- Main complet avec iostream et namespace
  s("maincpp", fmt([[
#include <iostream>

using namespace std;

int main() {{
    {}
    return 0;
}}
  ]], {
    i(1, "// Code here"),
  })),
  
  -- Main sans using namespace
  s("mainstd", fmt([[
#include <iostream>

int main() {{
    {}
    return 0;
}}
  ]], {
    i(1, "// Code here"),
  })),
  
  -- cout
  s("cout", fmt([[
std::cout << {} << std::endl;
  ]], {
    i(1, '"Hello"'),
  })),
  
  -- cin
  s("cin", fmt([[
std::cin >> {};
  ]], {
    i(1, "variable"),
  })),
  
  -- Classe complète
  s("class", fmt([[
class {} {{
private:
    {}

public:
    {}() {{
        {}
    }}
    
    ~{}() {{
    }}
    
    {}
}};
  ]], {
    i(1, "ClassName"),
    i(2, "// Private members"),
    ls.f(function(args) return args[1][1] end, {1}),  -- Répète le nom de la classe
    i(3, "// Constructor body"),
    ls.f(function(args) return args[1][1] end, {1}),  -- Répète pour le destructeur
    i(4, "// Public methods"),
  })),
  
  -- For loop
  s("fori", fmt([[
for (int {} = 0; {} < {}; {}++) {{
    {}
}}
  ]], {
    i(1, "i"),
    ls.f(function(args) return args[1][1] end, {1}),
    i(2, "n"),
    ls.f(function(args) return args[1][1] end, {1}),
    i(3, "// code"),
  })),
  
  -- Vector declaration
  s("vec", fmt([[
std::vector<{}> {};
  ]], {
    i(1, "int"),
    i(2, "vec"),
  })),
})

-- Snippets pour C
ls.add_snippets("c", {
  -- #include <stdio.h>
  s("stdio", {
    t('#include <stdio.h>'),
  }),
  
  -- #include <stdlib.h>
  s("stdlib", {
    t('#include <stdlib.h>'),
  }),
  
  -- #include <string.h>
  s("stringh", {
    t('#include <string.h>'),
  }),
  
  -- Main complet
  s("mainc", fmt([[
#include <stdio.h>

int main() {{
    {}
    return 0;
}}
  ]], {
    i(1, "// Code here"),
  })),
  
  -- printf
  s("printf", fmt([[
printf("{}\\n"{});
  ]], {
    i(1, "%d"),
    i(2, ", var"),
  })),
  
  -- scanf
  s("scanf", fmt([[
scanf("{}", {});
  ]], {
    i(1, "%d"),
    i(2, "&var"),
  })),
})

-- Snippets pour Python
ls.add_snippets("python", {
  -- Main
  s("main", fmt([[
def main():
    {}

if __name__ == "__main__":
    main()
  ]], {
    i(1, "pass"),
  })),
  
  -- Function
  s("def", fmt([[
def {}({}):
    """{}"""
    {}
  ]], {
    i(1, "function_name"),
    i(2, "args"),
    i(3, "Description"),
    i(4, "pass"),
  })),
  
  -- Class
  s("class", fmt([[
class {}: 
    """{}"""
    
    def __init__(self{}):
        {}
  ]], {
    i(1, "ClassName"),
    i(2, "Class description"),
    i(3, ", args"),
    i(4, "pass"),
  })),
  
  -- Import
  s("imp", fmt([[
import {}
  ]], {
    i(1, "module"),
  })),
  
  -- From import
  s("from", fmt([[
from {} import {}
  ]], {
    i(1, "module"),
    i(2, "something"),
  })),
})

-- Snippets pour Java
ls.add_snippets("java", {
  -- Main
  s("main", fmt([[
public static void main(String[] args) {{
    {}
}}
  ]], {
    i(1, "// Code here"),
  })),
  
  -- Class complète
  s("class", fmt([[
public class {} {{
    {}
    
    public {}() {{
        {}
    }}
    
    public static void main(String[] args) {{
        {}
    }}
}}
  ]], {
    i(1, "ClassName"),
    i(2, "// Fields"),
    ls.f(function(args) return args[1][1] end, {1}),
    i(3, "// Constructor"),
    i(4, "// Main"),
  })),
  
  -- System.out.println
  s("sout", fmt([[
System. out.println({});
  ]], {
    i(1, '"Hello"'),
  })),
})
