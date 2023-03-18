const docstring_Tidier_set =
"""
    Tidier_set(option::AbstractString, value::Bool)

Set package options.

Here are the supported options and what they do:

- "code": Defaults to `false`. If set to `true`, this option displays the DataFrames.jl code generated by the Tidier.jl package. It is useful for debugging whether errors are introduced by Tidier.jl's generated code.

# Arguments
- `option`: "code" 
- `value`: `true` or `false`
"""


const docstring_across =
"""
    across(variable[s], function[s])

Apply functions to multiple variables. If specifying multiple variables or functions, surround them with parentheses so that they are recognized as a tuple.

This function should only be called inside of Tidier.jl macros.

# Arguments
- `variable[s]`: An unquoted variable, or if multiple, an unquoted tuple of variables.
- `function[s]`: A function, or if multiple, a tuple of functions.

# Examples
```jldoctest
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @summarize(across(b, minimum))
       end
1×1 DataFrame
 Row │ b_minimum 
     │ Int64     
─────┼───────────
   1 │         1

julia> @chain df begin
       @summarize(across((b,c), (minimum, maximum)))
       end
1×4 DataFrame
 Row │ b_minimum  c_minimum  b_maximum  c_maximum 
     │ Int64      Int64      Int64      Int64     
─────┼────────────────────────────────────────────
   1 │         1         11          5         15

julia> @chain df begin
       @mutate(across((b,c), (minimum, maximum)))
       end
5×7 DataFrame
 Row │ a     b      c      b_minimum  c_minimum  b_maximum  c_maximum 
     │ Char  Int64  Int64  Int64      Int64      Int64      Int64     
─────┼────────────────────────────────────────────────────────────────
   1 │ a         1     11          1         11          5         15
   2 │ b         2     12          1         11          5         15
   3 │ c         3     13          1         11          5         15
   4 │ d         4     14          1         11          5         15
   5 │ e         5     15          1         11          5         15

julia> @chain df begin
       @mutate(across((b, starts_with("c")), (minimum, maximum)))
       end
5×7 DataFrame
 Row │ a     b      c      b_minimum  c_minimum  b_maximum  c_maximum 
     │ Char  Int64  Int64  Int64      Int64      Int64      Int64     
─────┼────────────────────────────────────────────────────────────────
   1 │ a         1     11          1         11          5         15
   2 │ b         2     12          1         11          5         15
   3 │ c         3     13          1         11          5         15
   4 │ d         4     14          1         11          5         15
   5 │ e         5     15          1         11          5         15

```
"""

const docstring_desc =
"""
    desc(col)

Orders the rows of a DataFrame column in descending order when used inside of `@arrange()`. This function should only be called inside of `@arrange()``.

# Arguments
- `col`: An unquoted column name.

# Examples
```jldoctest
julia> df = DataFrame(a = repeat('a':'e', inner = 2), b = 1:10, c = 11:20);
  
julia> @chain df begin
       @arrange(a, desc(b))
       end
10×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         2     12
   2 │ a         1     11
   3 │ b         4     14
   4 │ b         3     13
   5 │ c         6     16
   6 │ c         5     15
   7 │ d         8     18
   8 │ d         7     17
   9 │ e        10     20
  10 │ e         9     19
```
"""

const docstring_select =
"""
    @select(df, exprs...)

Select variables in a DataFrame.

# Arguments
- `df`: A DataFrame.
- `exprs...`: One or more unquoted variable names separated by commas. Variable names 
         can also be used as their positions in the data, like `x:y`, to select 
         a range of variables.

# Examples
```jldoctest 
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @select(a, b, c)
       end
5×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
   2 │ b         2     12
   3 │ c         3     13
   4 │ d         4     14
   5 │ e         5     15

julia> @chain df begin
       @select(a:b)
       end
5×2 DataFrame
 Row │ a     b     
     │ Char  Int64 
─────┼─────────────
   1 │ a         1
   2 │ b         2
   3 │ c         3
   4 │ d         4
   5 │ e         5

julia> @chain df begin
       @select(1:2)
       end
5×2 DataFrame
 Row │ a     b     
     │ Char  Int64 
─────┼─────────────
   1 │ a         1
   2 │ b         2
   3 │ c         3
   4 │ d         4
   5 │ e         5

julia> @chain df begin
       @select(-(a:b))
       end
5×1 DataFrame
 Row │ c     
     │ Int64 
─────┼───────
   1 │    11
   2 │    12
   3 │    13
   4 │    14
   5 │    15

julia> @chain df begin
       @select(!(a:b))
       end
5×1 DataFrame
 Row │ c     
     │ Int64 
─────┼───────
   1 │    11
   2 │    12
   3 │    13
   4 │    14
   5 │    15

julia> @chain df begin
       @select(contains("b"), starts_with("c"))
       end
5×2 DataFrame
 Row │ b      c     
     │ Int64  Int64 
─────┼──────────────
   1 │     1     11
   2 │     2     12
   3 │     3     13
   4 │     4     14
   5 │     5     15

julia> @chain df begin
       @select(-(1:2))
       end
5×1 DataFrame
 Row │ c     
     │ Int64 
─────┼───────
   1 │    11
   2 │    12
   3 │    13
   4 │    14
   5 │    15

julia> @chain df begin
       @select(!(1:2))
       end
5×1 DataFrame
 Row │ c     
     │ Int64 
─────┼───────
   1 │    11
   2 │    12
   3 │    13
   4 │    14
   5 │    15

julia> @chain df begin
       @select(-c)
       end
5×2 DataFrame
 Row │ a     b     
     │ Char  Int64 
─────┼─────────────
   1 │ a         1
   2 │ b         2
   3 │ c         3
   4 │ d         4
   5 │ e         5

julia> @chain df begin
       @select(-contains("a"))
       end
5×2 DataFrame
 Row │ b      c     
     │ Int64  Int64 
─────┼──────────────
   1 │     1     11
   2 │     2     12
   3 │     3     13
   4 │     4     14
   5 │     5     15
   
julia> @chain df begin
       @select(!contains("a"))
       end
5×2 DataFrame
 Row │ b      c     
     │ Int64  Int64 
─────┼──────────────
   1 │     1     11
   2 │     2     12
   3 │     3     13
   4 │     4     14
   5 │     5     15
```
"""

const docstring_transmute =
"""
    @transmute(df, exprs...)

Create a new DataFrame with only computed columns.

# Arguments
- `df`: A DataFrame.
- `exprs...`: add new columns or replace values of existed columns using
         `new_variable = values` syntax.

# Examples
```jldoctest 
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @transmute(d = b + c)
       end
5×1 DataFrame
 Row │ d     
     │ Int64 
─────┼───────
   1 │    12
   2 │    14
   3 │    16
   4 │    18
   5 │    20
```
"""

const docstring_rename =
"""
    @rename(df, exprs...)

Change the names of individual column names in a DataFrame. Users can also use `@select()`
to rename and select columns.

# Arguments
- `df`: A DataFrame.
- `exprs...`: Use `new_name = old_name` syntax to rename selected columns.

# Examples
```jldoctest 
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @rename(d = b, e = c)
       end
5×3 DataFrame
 Row │ a     d      e     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
   2 │ b         2     12
   3 │ c         3     13
   4 │ d         4     14
   5 │ e         5     15
```
"""

const docstring_mutate =
"""
    @mutate(df, exprs...)
  
Create new columns as functions of existing columns. The results have the same number of
rows as `df`.

# Arguments
- `df`: A DataFrame.
- `exprs...`: add new columns or replace values of existed columns using
         `new_variable = values` syntax.

# Examples
```jldoctest 
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @mutate(d = b + c, b_minus_mean_b = b - mean(b))
       end
5×5 DataFrame
 Row │ a     b      c      d      b_minus_mean_b 
     │ Char  Int64  Int64  Int64  Float64        
─────┼───────────────────────────────────────────
   1 │ a         1     11     12            -2.0
   2 │ b         2     12     14            -1.0
   3 │ c         3     13     16             0.0
   4 │ d         4     14     18             1.0
   5 │ e         5     15     20             2.0

julia> @chain df begin
       @mutate(d = b in (1,3))
       end
5×4 DataFrame
 Row │ a     b      c      d     
     │ Char  Int64  Int64  Bool  
─────┼───────────────────────────
   1 │ a         1     11   true
   2 │ b         2     12  false
   3 │ c         3     13   true
   4 │ d         4     14  false
   5 │ e         5     15  false

julia> @chain df begin
       @mutate(across((b, c), mean))
       end
5×5 DataFrame
 Row │ a     b      c      b_mean   c_mean  
     │ Char  Int64  Int64  Float64  Float64 
─────┼──────────────────────────────────────
   1 │ a         1     11      3.0     13.0
   2 │ b         2     12      3.0     13.0
   3 │ c         3     13      3.0     13.0
   4 │ d         4     14      3.0     13.0
   5 │ e         5     15      3.0     13.0

julia> @chain df begin
       @summarize(across(contains("b"), mean))
       end
1×1 DataFrame
 Row │ b_mean  
     │ Float64 
─────┼─────────
   1 │     3.0

julia> @chain df begin
       @summarize(across(-contains("a"), mean))
       end
1×2 DataFrame
 Row │ b_mean   c_mean  
     │ Float64  Float64 
─────┼──────────────────
   1 │     3.0     13.0
```
"""

const docstring_summarize =
"""
    @summarize(df, exprs...)
    @summarise(df, exprs...)

Create a new DataFrame with one row that aggregating all observations from the input DataFrame or GroupedDataFrame. 

# Arguments
- `df`: A DataFrame.
- `exprs...`: a `new_variable = function(old_variable)` pair. `function()` should be an aggregate function that returns a single value. 

# Examples
```jldoctest 
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @summarize(mean_b = mean(b), median_b = median(b))
       end
1×2 DataFrame
 Row │ mean_b   median_b 
     │ Float64  Float64  
─────┼───────────────────
   1 │     3.0       3.0
  
julia> @chain df begin
       @summarise(mean_b = mean(b), median_b = median(b))
       end
1×2 DataFrame
 Row │ mean_b   median_b 
     │ Float64  Float64  
─────┼───────────────────
   1 │     3.0       3.0
   
julia> @chain df begin
       @summarize(across((b,c), (minimum, maximum)))
       end
1×4 DataFrame
 Row │ b_minimum  c_minimum  b_maximum  c_maximum 
     │ Int64      Int64      Int64      Int64     
─────┼────────────────────────────────────────────
   1 │         1         11          5         15
```
"""

const docstring_filter =
"""
    @filter(df, exprs...)

Subset a DataFrame and return a copy of DataFrame where specified conditions are satisfied.

# Arguments
- `df`: A DataFrame.
- `exprs...`: transformation(s) that produce vectors containing `true` or `false`.

# Examples
```jldoctest 
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @filter(b >= mean(b))
       end
3×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ c         3     13
   2 │ d         4     14
   3 │ e         5     15

julia> @chain df begin
       @filter(b in (1, 3))
       end
2×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
   2 │ c         3     13
```
"""

const docstring_group_by =
"""
    @group_by(df, exprs...)

Return a `GroupedDataFrame` where operations are performed by groups specified by unique 
sets of `cols`.

# Arguments
- `df`: A DataFrame.
- `exprs...`: DataFrame columns to group by or tidy expressions. Can be a single tidy expression or multiple expressions separated by commas.

# Examples
```jldoctest 
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @group_by(a)
       @summarize(b = mean(b))
       end
5×2 DataFrame
 Row │ a     b       
     │ Char  Float64 
─────┼───────────────
   1 │ a         1.0
   2 │ b         2.0
   3 │ c         3.0
   4 │ d         4.0
   5 │ e         5.0  

julia> @chain df begin
       @group_by(d = uppercase(a))
       @summarize(b = mean(b))
       end
5×2 DataFrame
 Row │ d     b       
     │ Char  Float64 
─────┼───────────────
   1 │ A         1.0
   2 │ B         2.0
   3 │ C         3.0
   4 │ D         4.0
   5 │ E         5.0
```
"""

const docstring_ungroup = 
"""
    @ungroup(df)

Return a `DataFrame` with all groups removed.

If this is applied to a `GroupedDataFrame`, then it removes the grouping. If this is applied to a `DataFrame` (without any groups), then it returns the `DataFrame` unchanged.

# Arguments
- `df`: A `GroupedDataFrame` or `DataFrame``.

# Examples
```jldoctest 
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @group_by(a)
       end
GroupedDataFrame with 5 groups based on key: a
First Group (1 row): a = 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
⋮
Last Group (1 row): a = 'e': ASCII/Unicode U+0065 (category Ll: Letter, lowercase)
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ e         5     15

julia> @chain df begin
       @group_by(a)
       @ungroup
       end
5×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
   2 │ b         2     12
   3 │ c         3     13
   4 │ d         4     14
   5 │ e         5     15
```
"""

const docstring_slice =
"""
    @slice(df, exprs...)

Select, remove or duplicate rows by indexing their integer positions.

# Arguments
- `df`: A DataFrame.
- `exprs...`: integer row values. Use positive values to keep the rows, or negative values to drop. Values provided must be either all positive or all negative, and they must be within the range of DataFrames' row numbers.

# Examples
```jldoctest 
julia> df = DataFrame(a = repeat('a':'e'), b = 1:5, c = 11:15);

julia> @chain df begin
       @slice(1:5)
       end
5×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
   2 │ b         2     12
   3 │ c         3     13
   4 │ d         4     14
   5 │ e         5     15

julia> @chain df begin
       @slice(-(1:2))
       end
3×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ c         3     13
   2 │ d         4     14
   3 │ e         5     15

julia> @chain df begin
       @group_by(a)
       @slice(1)
       @ungroup
       end
5×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
   2 │ b         2     12
   3 │ c         3     13
   4 │ d         4     14
   5 │ e         5     15
```         
"""

const docstring_arrange =
"""
    @arrange(df, exprs...)

Order the rows of a DataFrame by the values of specified columns.

# Arguments
- `df`: A DataFrame.
- `exprs...`: Variables from the input DataFrame. Use `desc()` to sort in descending order. Multiple variables can be specified, separated by commas.

# Examples
```jldoctest
julia> df = DataFrame(a = repeat('a':'e', inner = 2), b = 1:10, c = 11:20);
  
julia> @chain df begin
       @arrange(a)
       end
10×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
   2 │ a         2     12
   3 │ b         3     13
   4 │ b         4     14
   5 │ c         5     15
   6 │ c         6     16
   7 │ d         7     17
   8 │ d         8     18
   9 │ e         9     19
  10 │ e        10     20

julia> @chain df begin
       @arrange(a, desc(b))
       end
10×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         2     12
   2 │ a         1     11
   3 │ b         4     14
   4 │ b         3     13
   5 │ c         6     16
   6 │ c         5     15
   7 │ d         8     18
   8 │ d         7     17
   9 │ e        10     20
  10 │ e         9     19
```
"""

const docstring_distinct =
"""
    distinct(df, exprs...)

Return distinct rows of a DataFrame.

If no columns or expressions are provided, then unique rows across all columns are returned. Otherwise, unique rows are determined based on the columns or expressions provided, and then all columns are returned.

# Arguments
- `df`: A DataFrame.
- `exprs...`: One or more unquoted variable names separated by commas. Variable names 
         can also be used as their positions in the data, like `x:y`, to select 
         a range of variables.

# Examples
```jldoctest
julia> df = DataFrame(a = repeat('a':'e', inner = 2), b = 1:10, c = 11:20);
  
julia> @chain df begin
       @distinct()
       end
10×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
   2 │ a         2     12
   3 │ b         3     13
   4 │ b         4     14
   5 │ c         5     15
   6 │ c         6     16
   7 │ d         7     17
   8 │ d         8     18
   9 │ e         9     19
  10 │ e        10     20

julia> @chain df begin
       @distinct(a)
       end
5×3 DataFrame
 Row │ a     b      c     
     │ Char  Int64  Int64 
─────┼────────────────────
   1 │ a         1     11
   2 │ b         3     13
   3 │ c         5     15
   4 │ d         7     17
   5 │ e         9     19
```
"""

const docstring_pull =
"""
    @pull(df, column)

Pull (or extract) a column as a vector.

# Arguments
- `df`: A DataFrame.
- `column`: A single column, referred to either by its name or number.

# Examples
```jldoctest
julia> df = DataFrame(a = 'a':'e', b = 1:5, c = 11:15);
  
julia> @chain df begin
       @pull(a)
       end
5-element Vector{Char}:
 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
 'b': ASCII/Unicode U+0062 (category Ll: Letter, lowercase)
 'c': ASCII/Unicode U+0063 (category Ll: Letter, lowercase)
 'd': ASCII/Unicode U+0064 (category Ll: Letter, lowercase)
 'e': ASCII/Unicode U+0065 (category Ll: Letter, lowercase)

julia> @chain df begin
       @pull(2)
       end
5-element Vector{Int64}:
 1
 2
 3
 4
 5
```
"""

const docstring_left_join =
"""
    @left_join(df1, df2, [by])

Perform a left join on `df1` and `df` with an optional `by`.

# Arguments
- `df1`: A DataFrame.
- `df2`: A DataFrame.
- `by`: An optional column or tuple of columns. `by` supports interpolation of individual columns. If `by` is not supplied, then it will be inferred from shared names of columns between `df1` and `df2`.

# Examples
```jldoctest
julia> df1 = DataFrame(a = ["a", "b"], b = 1:2);

julia> df2 = DataFrame(a = ["a", "c"], c = 3:4);
  
julia> @left_join(df1, df2)
2×3 DataFrame
 Row │ a       b      c       
     │ String  Int64  Int64?  
─────┼────────────────────────
   1 │ a           1        3
   2 │ b           2  missing 

julia> @left_join(df1, df2, a)
2×3 DataFrame
 Row │ a       b      c       
     │ String  Int64  Int64?  
─────┼────────────────────────
   1 │ a           1        3
   2 │ b           2  missing

julia> @left_join(df1, df2, a = a)
2×3 DataFrame
 Row │ a       b      c       
     │ String  Int64  Int64?  
─────┼────────────────────────
   1 │ a           1        3
   2 │ b           2  missing

julia> @left_join(df1, df2, "a")
2×3 DataFrame
 Row │ a       b      c       
     │ String  Int64  Int64?  
─────┼────────────────────────
   1 │ a           1        3
   2 │ b           2  missing

julia> @left_join(df1, df2, "a" = "a")
2×3 DataFrame
 Row │ a       b      c       
     │ String  Int64  Int64?  
─────┼────────────────────────
   1 │ a           1        3
   2 │ b           2  missing
```
"""

const docstring_right_join =
"""
    @right_join(df1, df2, [by])

Perform a right join on `df1` and `df` with an optional `by`.

# Arguments
- `df1`: A DataFrame.
- `df2`: A DataFrame.
- `by`: An optional column or tuple of columns. `by` supports interpolation of individual columns. If `by` is not supplied, then it will be inferred from shared names of columns between `df1` and `df2`.

# Examples
```jldoctest
julia> df1 = DataFrame(a = ["a", "b"], b = 1:2);

julia> df2 = DataFrame(a = ["a", "c"], c = 3:4);
  
julia> @right_join(df1, df2)
2×3 DataFrame
 Row │ a       b        c     
     │ String  Int64?   Int64 
─────┼────────────────────────
   1 │ a             1      3
   2 │ c       missing      4

julia> @right_join(df1, df2, a)
2×3 DataFrame
 Row │ a       b        c     
     │ String  Int64?   Int64 
─────┼────────────────────────
   1 │ a             1      3
   2 │ c       missing      4

julia> @right_join(df1, df2, a = a)
2×3 DataFrame
 Row │ a       b        c     
     │ String  Int64?   Int64 
─────┼────────────────────────
   1 │ a             1      3
   2 │ c       missing      4

julia> @right_join(df1, df2, "a")
2×3 DataFrame
 Row │ a       b        c     
     │ String  Int64?   Int64 
─────┼────────────────────────
   1 │ a             1      3
   2 │ c       missing      4

julia> @right_join(df1, df2, "a" = "a")
2×3 DataFrame
 Row │ a       b        c     
     │ String  Int64?   Int64 
─────┼────────────────────────
   1 │ a             1      3
   2 │ c       missing      4
```
"""

const docstring_inner_join =
"""
    @inner_join(df1, df2, [by])

Perform a inner join on `df1` and `df` with an optional `by`.

# Arguments
- `df1`: A DataFrame.
- `df2`: A DataFrame.
- `by`: An optional column or tuple of columns. `by` supports interpolation of individual columns. If `by` is not supplied, then it will be inferred from shared names of columns between `df1` and `df2`.

# Examples
```jldoctest
julia> df1 = DataFrame(a = ["a", "b"], b = 1:2);

julia> df2 = DataFrame(a = ["a", "c"], c = 3:4);
  
julia> @inner_join(df1, df2)
1×3 DataFrame
 Row │ a       b      c     
     │ String  Int64  Int64 
─────┼──────────────────────
   1 │ a           1      3

julia> @inner_join(df1, df2, a)
1×3 DataFrame
 Row │ a       b      c     
     │ String  Int64  Int64 
─────┼──────────────────────
   1 │ a           1      3

julia> @inner_join(df1, df2, a = a)
1×3 DataFrame
 Row │ a       b      c     
     │ String  Int64  Int64 
─────┼──────────────────────
   1 │ a           1      3

julia> @inner_join(df1, df2, "a")
1×3 DataFrame
 Row │ a       b      c     
     │ String  Int64  Int64 
─────┼──────────────────────
   1 │ a           1      3

julia> @inner_join(df1, df2, "a" = "a")
1×3 DataFrame
 Row │ a       b      c     
     │ String  Int64  Int64 
─────┼──────────────────────
   1 │ a           1      3
```
"""

const docstring_full_join =
"""
    @full_join(df1, df2, [by])

Perform a full join on `df1` and `df` with an optional `by`.

# Arguments
- `df1`: A DataFrame.
- `df2`: A DataFrame.
- `by`: An optional column or tuple of columns. `by` supports interpolation of individual columns. If `by` is not supplied, then it will be inferred from shared names of columns between `df1` and `df2`.

# Examples
```jldoctest
julia> df1 = DataFrame(a = ["a", "b"], b = 1:2);

julia> df2 = DataFrame(a = ["a", "c"], c = 3:4);
  
julia> @full_join(df1, df2)
3×3 DataFrame
 Row │ a       b        c       
     │ String  Int64?   Int64?  
─────┼──────────────────────────
   1 │ a             1        3
   2 │ b             2  missing 
   3 │ c       missing        4

julia> @full_join(df1, df2, a)
3×3 DataFrame
 Row │ a       b        c       
     │ String  Int64?   Int64?  
─────┼──────────────────────────
   1 │ a             1        3
   2 │ b             2  missing 
   3 │ c       missing        4

julia> @full_join(df1, df2, a = a)
3×3 DataFrame
 Row │ a       b        c       
     │ String  Int64?   Int64?  
─────┼──────────────────────────
   1 │ a             1        3
   2 │ b             2  missing 
   3 │ c       missing        4

julia> @full_join(df1, df2, "a")
3×3 DataFrame
 Row │ a       b        c       
     │ String  Int64?   Int64?  
─────┼──────────────────────────
   1 │ a             1        3
   2 │ b             2  missing 
   3 │ c       missing        4

julia> @full_join(df1, df2, "a" = "a")
3×3 DataFrame
 Row │ a       b        c       
     │ String  Int64?   Int64?  
─────┼──────────────────────────
   1 │ a             1        3
   2 │ b             2  missing 
   3 │ c       missing        4
```
"""

const docstring_pivot_wider =
"""
   @pivot_wider(df, names_from, values_from)

Reshapes the DataFrame to make it wider, increasing the number of columns and reducing the number of rows.

# Arguments
- `df`: A DataFrame.
- `names_from`: The name of the column to get the name of the output columns from.
- `values_from`: The name of the column to get the cell values from.

# Examples
```jldoctest
julia> df_long = DataFrame(id = [1, 1, 2, 2],
                           variable = ["A", "B", "A", "B"],
                           value = [1, 2, 3, 4]);

julia> df_long_missing = DataFrame(id = [1, 1, 2],
                           variable = ["A", "B", "B"],
                           value = [1, 2, 4]);

julia> @pivot_wider(df_long, names_from = variable, values_from = value)
2×3 DataFrame
 Row │ id     A       B      
     │ Int64  Int64?  Int64?
─────┼───────────────────────
   1 │     1       1       2
   2 │     2       3       4

julia> @pivot_wider(df_long, names_from = "variable", values_from = "value")
2×3 DataFrame
 Row │ id     A       B      
     │ Int64  Int64?  Int64?
─────┼───────────────────────
   1 │     1       1       2
   2 │     2       3       4

julia> @pivot_wider(df_long_missing, names_from = variable, values_from = value, values_fill = 0)
2×3 DataFrame
 Row │ id     A      B     
     │ Int64  Int64  Int64
─────┼─────────────────────
   1 │     1      1      2
   2 │     2      0      4
```
"""

const docstring_pivot_longer =
"""
   @pivot_longer(df, cols, [names_to], [values_to])

Reshapes the DataFrame to make it longer, increasing the number of rows and reducing the number of columns.

# Arguments
- `df`: A DataFrame.
- `cols`: Columns to pivot into longer format. Multiple columns can be selected but providing tuples of columns is not yet supported.
- `names_to`: Optional, defaults to `variable`. The name of the newly created column whose values will contain the input DataFrame's column names.
- `values_to`: Optional, defaults to `value`. The name of the newly created column containing the input DataFrame's cell values.

# Examples
```jldoctest
julia> df_wide = DataFrame(id = [1, 2], A = [1, 3], B = [2, 4]);

julia> @pivot_longer(df_wide, A:B)
4×3 DataFrame
 Row │ id     variable  value 
     │ Int64  String    Int64
─────┼────────────────────────
   1 │     1  A             1
   2 │     2  A             3
   3 │     1  B             2
   4 │     2  B             4

julia> @pivot_longer(df_wide, -id)
4×3 DataFrame
 Row │ id     variable  value 
     │ Int64  String    Int64
─────┼────────────────────────
   1 │     1  A             1
   2 │     2  A             3
   3 │     1  B             2
   4 │     2  B             4

julia> @pivot_longer(df_wide, A:B, names_to = "letter", values_to = "number")
4×3 DataFrame
 Row │ id     letter  number 
     │ Int64  String  Int64
─────┼───────────────────────
   1 │     1  A            1
   2 │     2  A            3
   3 │     1  B            2
   4 │     2  B            4

julia> @pivot_longer(df_wide, A:B, names_to = letter, values_to = number)
4×3 DataFrame
 Row │ id     letter  number 
     │ Int64  String  Int64
─────┼───────────────────────
   1 │     1  A            1
   2 │     2  A            3
   3 │     1  B            2
   4 │     2  B            4

julia> @pivot_longer(df_wide, A:B, names_to = "letter")
4×3 DataFrame
 Row │ id     letter  value 
     │ Int64  String  Int64
─────┼──────────────────────
   1 │     1  A           1
   2 │     2  A           3
   3 │     1  B           2
   4 │     2  B           4

```
"""

const docstring_if_else =
"""
    if_else(condition, yes, no, [miss])

Return the `yes` value if the `condition` is `true` and the `no` value if the `condition` is `false`. If `miss` is specified, then the provided `miss` value is returned when the `condition` contains a `missing` value. If `miss` is not specified, then the returned value is an explicit `missing` value.

# Arguments
- `condition`: A condition that evaluates to `true`, `false`, or `missing`.
- `yes`: Value to return if the condition is `true`.
- `no`: Value to return if the condition is `false`.
- `miss`: Optional. Value to return if the condition is `missing`.

# Examples
```jldoctest
julia> df = DataFrame(a = [1, 2, missing, 4, 5]);

julia> @chain df begin
       @mutate(b = if_else(a >= 3, "yes", "no"))
       end
5×2 DataFrame
 Row │ a        b       
     │ Int64?   String? 
─────┼──────────────────
   1 │       1  no
   2 │       2  no
   3 │ missing  missing 
   4 │       4  yes
   5 │       5  yes

julia> @chain df begin
       @mutate(b = if_else(a >= 3, "yes", "no", "unknown"))
       end
5×2 DataFrame
 Row │ a        b       
     │ Int64?   String  
─────┼──────────────────
   1 │       1  no
   2 │       2  no
   3 │ missing  unknown
   4 │       4  yes
   5 │       5  yes

julia> @chain df begin
       @mutate(b = if_else(a >= 3, 3, a))
       end
5×2 DataFrame
 Row │ a        b       
     │ Int64?   Int64?  
─────┼──────────────────
   1 │       1        1
   2 │       2        2
   3 │ missing  missing 
   4 │       4        3
   5 │       5        3

julia> @chain df begin
       @mutate(b = if_else(a >= 3, 3, a, 0))
       end
5×2 DataFrame
 Row │ a        b     
     │ Int64?   Int64 
─────┼────────────────
   1 │       1      1
   2 │       2      2
   3 │ missing      0
   4 │       4      3
   5 │       5      3
```
"""

const docstring_case_when =
"""
    case_when(condition => return_value)
    case_when(condition_1 => return_value_1, condition_2 => return_value_2, ...)

Return the corresponding `return_value` for the first `condition` that evaluates to `true`.

The most specific condition should be listed first and most general condition should be listed last. If none of the conditions evaluate to `true`, then a `missing` value is returned. 

# Arguments
- `condition`: A condition that evaluates to `true`, `false`, or `missing`.
- `return_value`: The value to return if the condition is `true`.

# Examples
```jldoctest
julia> df = DataFrame(a = [1, 2, missing, 4, 5]);

julia> @chain df begin
       @mutate(b = case_when(a > 4  =>  "hi",
                             a > 2  =>  "medium",
                             a > 0  =>  "low"))
       end
5×2 DataFrame
 Row │ a        b       
     │ Int64?   String? 
─────┼──────────────────
   1 │       1  low
   2 │       2  low
   3 │ missing  missing 
   4 │       4  medium
   5 │       5  hi

julia> @chain df begin
       @mutate(b = case_when(a > 4  =>  "hi",
                             a > 2  =>  "medium",
                             a > 0  =>  "low",
                             true   =>  "unknown"))
       end
5×2 DataFrame
 Row │ a        b       
     │ Int64?   String  
─────┼──────────────────
   1 │       1  low
   2 │       2  low
   3 │ missing  unknown
   4 │       4  medium
   5 │       5  hi

julia> @chain df begin
       @mutate(b = case_when(a >= 3  =>  3,
                             true    =>  a))
       end
5×2 DataFrame
 Row │ a        b       
     │ Int64?   Int64?  
─────┼──────────────────
   1 │       1        1
   2 │       2        2
   3 │ missing  missing 
   4 │       4        3
   5 │       5        3

julia> @chain df begin
       @mutate(b = case_when(a >= 3        =>  3,
                             ismissing(a)  =>  0,
                             true          =>  a))
       end
5×2 DataFrame
 Row │ a        b     
     │ Int64?   Int64 
─────┼────────────────
   1 │       1      1
   2 │       2      2
   3 │ missing      0
   4 │       4      3
   5 │       5      3
```
"""

const docstring_n =
"""
    n()

Return the number of rows in the DataFrame or in the group if used in the context of a GroupedDataFrame.

# Arguments
- None

# Examples
```jldoctest
julia> df = DataFrame(a = repeat('a':'e', inner = 2), b = 1:10, c = 11:20);

julia> @chain df begin
       @summarize(n = n())
       end
1×1 DataFrame
 Row │ n     
     │ Int64 
─────┼───────
   1 │    10

julia> @chain df begin
       @group_by(a)
       @summarize(n = n())
       end
5×2 DataFrame
 Row │ a     n     
     │ Char  Int64 
─────┼─────────────
   1 │ a         2
   2 │ b         2
   3 │ c         2
   4 │ d         2
   5 │ e         2
```
"""

const docstring_row_number =
"""
    row_number()

Return each row's number in a DataFrame or in the group if used in the context of a GroupedDataFrame.

# Arguments
- None

# Examples
```jldoctest
julia> df = DataFrame(a = repeat('a':'e', inner = 2));

julia> @chain df begin
       @mutate(row_num = row_number())
       end
10×2 DataFrame
 Row │ a     row_num 
     │ Char  Int64   
─────┼───────────────
   1 │ a           1
   2 │ a           2
   3 │ b           3
   4 │ b           4
   5 │ c           5
   6 │ c           6
   7 │ d           7
   8 │ d           8
   9 │ e           9
  10 │ e          10

julia> @chain df begin
       @mutate(row_num = row_number() + 1)
       end
10×2 DataFrame
 Row │ a     row_num 
     │ Char  Int64   
─────┼───────────────
   1 │ a           2
   2 │ a           3
   3 │ b           4
   4 │ b           5
   5 │ c           6
   6 │ c           7
   7 │ d           8
   8 │ d           9
   9 │ e          10
  10 │ e          11

julia> @chain df begin
       @filter(row_number() <= 5)
       end
5×1 DataFrame
 Row │ a    
     │ Char 
─────┼──────
   1 │ a
   2 │ a
   3 │ b
   4 │ b
   5 │ c
```
"""