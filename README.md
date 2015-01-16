[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/vprokopchuk256/mv-mysql/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
[![Build Status](https://travis-ci.org/vprokopchuk256/mv-mysql.svg?branch=master)](https://travis-ci.org/vprokopchuk256/mv-mysql)
[![Coverage Status](https://coveralls.io/repos/vprokopchuk256/mv-mysql/badge.png?branch=master)](https://coveralls.io/r/vprokopchuk256/mv-mysql?branch=master)
[![Gem Version](https://badge.fury.io/rb/mv-mysql.svg)](http://badge.fury.io/rb/mv-mysql)

# Introduction

mv-mysql is the MySQL driver for Migration Validators project (details here: https://github.com/vprokopchuk256/mv-core)

### uniqueness

  Examples:

  validate uniqueness of the column 'column_name':

  ```ruby
  validates :table_name, :column_name, uniqueness: true
  ```

  define validation as trigger with specified failure message:

  ```ruby
  validates :table_name, :column_name, 
            uniqueness: { message: 'Error message', as: :trigger }
  ```

  define validation as unique index: 

  ```ruby
  validates :table_name, :column_name, uniqueness: { as: :index }
  ```

  all above are available in a create and change table blocks: 

  ```ruby
  create_table :table_name do |t|
     t.string :column_name, validates: { uniqueness: true }
  end
  ```

  ```ruby
  change :table_name do |t|
     t.change :column_name, :string, :validates: { uniqueness: false }
  end
  ```

  Options: 

  * `:message` - text of the error message that will be shown if constraint violated.  Ignored unless `:as == :trigger`
  * `:index_name` - name of the index that will be created for validator. Ignored unless `:as == :index`
  * `:on` - validation event. Possible values `[:save, :update, :create]`. Ignored unless `:as == :trigger`. Default value `:save`
  * `:create_tigger_name` - name of the 'before insert' trigger that will be created if `:as == :trigger` && `:on` in `[:save, :create]`
  * `:update_tigger_name` - name of the 'before update' trigger that will be created if `:as == :trigger` && `:on` in `[:save, :update]`
  * `:allow_nil` - ignore validation for nil values. Ignored unless `:as == :trigger`. Default value: `false`
  * `:allow_blank` - ignore validation for blank values. Ignored unless `:as == :trigger`. Default value: `false`
  * `:as` - defines the way how constraint will be implemented. Possible values: `[:index, :trigger]`. Default value: `:index`

### length

  Examples: 

  column value length should be more than 4 symbols and less than 9. Otherwise 'Wrong length message' error will be raised: 

 ```ruby 
  validates :table_name, :column_name, 
                         length: { in: 5..8, 
                                   message: 'Wrong length message' }
 ```

 allow `NULL`:

  ```ruby
  validates :table_name, :column_name, 
                         length: { is: 3, allow_nil: true}
  ```

  allow blank values: 

  ```ruby
  validates :table_name, :column_name, 
                        length: { maximum: 3, 
                                  too_long: 'Value is longer than 3 symbols' } 
  ```

  Options:

  * `:in`- range or array that length of the value should be contained in.
  * `:within` - synonym of `:in`
  * `:is`- exact length of the value
  * `:maximum`- maximum allowed length
  * `:minimum`- minimum allowed length
  * `:message`- message that should be shown if validation failed and specific message is not defined
  * `:too_long`- message that will be shown if value longer than allowed. Ignored unless maximum value is defined
  * `:too_short`- message that will be shown if value shorter than allowed. Ignored unless minimum value is defined
  * `:on`- validation event. Possible values `[:save, :update, :create]`. Default value: `:save` 
  * `:create_tigger_name`- Name of the 'before insert' trigger
  * `:update_tigger_name`- Name of the 'before update' trigger
  * `:allow_nil`- ignore validation for nil values. Default value: `false`
  * `:allow_blank`- ignore validation for blank values. Default value: `false`
  * `:as`- defines the way how constraint will be implemented. Possible values: `[:trigger]`

### inclusion

  Examples:

  valid values array: 

  ```ruby
  validates :table_name, :column_name, inclusion: { in: [1, 2, 3]}
  ```

  with failure message specified: 

  ```ruby
  validates :table_name, :column_name, 
  inclusion: { in: [1, 2, 3], 
               message: "Column 'column_name' should be equal to 1 or 2 or 3" }
  ```

  Options:

  * `:in range` - or array that column value should be contained in.
  * `:message message` - that should be shown if validation failed
  * `:on  validation` - event. Possible values `[:save, :update, :create]`. Default value: `:save`
  * `:create_tigger_name` - Name of the 'before insert' trigger 
  * `:update_tigger_name` - Name of the 'before update' trigger
  * `:allow_nil` - ignore validation for nil values. Default value: `false`
  * `:allow_blank` - ignore validation for blank values. Default value: `false`
  * `:as` - defines the way how constraint will be implemented. Possible values: `[:trigger]`

  
### exclusion

  Examples:

  exclude 1, 2, and 3: 

  ```ruby
  validates :table_name, :column_name, exclusion: { in: [1, 2, 3] }
  ```

  exclude values with specified failure message:

  ```ruby
  validates :table_name, :column_name, 
    exclusion: { 
        in: [1, 2, 3], 
        message: "Column 'column_name' should not  be equal to 1 or 2 or 3"
    }
  ```

  performs verification on update only:

  ```ruby
  validates :table_name, :column_name, 
                               exclusion: { in: [1, 2, 3], 
                                            on: :update }
  ```

  Options:

  * `:in` - range or array that column value should NOT be contained in.
  message: message that should be shown if validation failed
  * `:on` - validation event. Possible values `[:save, :update, :create]`. Default value: :save
  *`:create_tigger_name` - name of the 'before insert' trigger
  *`:update_tigger_name` - name of the 'before update' trigger
  *`:allow_nil` - ignore validation for nil values. Default value: false
  *`:allow_blank` - ignore validation for blank values. Default value: false
  *`:as` - defines the way how constraint will be implemented. Possible values: `[:trigger]`

### presence

  Examples:

  simple presence validator: 

  ```ruby
  validates :table_name, :column_name, presence: true
  ```

  with failure message: 

  ```ruby
  validates :table_name, :column_name, 
                  :presence: { message: 'value should not be empty' }
  ```

  performs verification only when new record is inserted:

  ```ruby
  validates :table_name, :column_name, 
                  presence: { message: 'value should not be empty', 
                              on: :create }
  ```

### absence

  Examples:

  simple absence validator: 

  ```ruby
  validates :table_name, :column_name, absence: true
  ```

  with failure message: 

  ```ruby
  validates :table_name, :column_name, 
                         :absence: { message: 'value should not empty' }
  ```

  performs verification only when new record is inserted:

  ```ruby
  validates :table_name, :column_name, 
                         absence: { message: 'value should not empty', 
                                    on: :create }
  ```

  Options:

  * `:message` - message that should be shown if validation failed
  `:on`  validation event. Possible values `[:save, :update, :create]`. Default value: `:save`
  * `:create_tigger_name` - name of the 'before insert' trigger
  * `:update_tigger_name` - name of the 'before update' trigger
  * `:allow_nil` - ignore validation for nil values. Default value: false
  * `:allow_blank` - ignore validation for blank values. Default value: `false`
  * `:as` - defines the way how constraint will be implemented. Possible values: `[:trigger]`

  Options:

  * `:with` - regular expression that column value should be matched to
  * `:message` - message that should be shown if validation failed
  * `:on` - validation event. Possible values `[:save, :update, :create]`. Default value: `:save`
  * `:create_tigger_name` - name of the 'before insert' trigger
  * `:update_tigger_name` - name of the 'before update' trigger
  * `:allow_nil` - ignore validation for nil values. Default value: `false`
  * `:allow_blank` - ignore validation for blank values. Default value: `false`
  * `:as` - defines the way how constraint will be implemented. Possible values: `[:trigger]`

## Contributing to mv-mysql
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Valeriy Prokopchuk. See LICENSE.txt for
further details.
