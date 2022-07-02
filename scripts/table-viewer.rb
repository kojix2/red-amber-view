# frozen_string_literal: true

require 'libui'
require 'arrow'

LibUI.init

main_window = LibUI.new_window('RedAmber::View', 600, 400, 1)

hbox = LibUI.new_horizontal_box
LibUI.window_set_child(main_window, hbox)

arrow_table = Arrow::Table.load(ARGV[0])
ncol = arrow_table.n_columns
nrow = arrow_table.n_rows

# Protects BlockCaller objects from garbage collection.
@block_callers = []
def rbcallback(*args, &block)
  args << [0] if args.size == 1 # Argument types are ommited
  block_caller = Fiddle::Closure::BlockCaller.new(*args, &block)
  @block_callers << block_caller
  block_caller
end

model_handler = LibUI::FFI::TableModelHandler.malloc
model_handler.to_ptr.free = Fiddle::RUBY_FREE
model_handler.NumColumns   = rbcallback(4) { ncol }
model_handler.ColumnType   = rbcallback(4) { 0 }
model_handler.NumRows      = rbcallback(4) { nrow }
model_handler.CellValue    = rbcallback(1, [1, 1, 4, 4]) do |_, _, row, column|
  str = arrow_table.get_column_data(column)[row].to_s
  LibUI.new_table_value_string(str)
end
model_handler.SetCellValue = rbcallback(0, [0]) {}

model = LibUI.new_table_model(model_handler)

table_params = LibUI::FFI::TableParams.malloc
table_params.to_ptr.free = Fiddle::RUBY_FREE
table_params.Model = model
table_params.RowBackgroundColorModelColumn = -1

table = LibUI.new_table(table_params)
arrow_table.columns.map.with_index do |column, i|
  name = column.name.to_s
  LibUI.table_append_text_column(table, name, i, -1)
end

LibUI.box_append(hbox, table, 1)
LibUI.control_show(main_window)

LibUI.window_on_closing(main_window) do
  LibUI.control_destroy(main_window)
  LibUI.free_table_model(model)
  LibUI.quit
  0
end

LibUI.main
LibUI.quit
