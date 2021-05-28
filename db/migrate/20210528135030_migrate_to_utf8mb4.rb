class MigrateToUtf8mb4 < ActiveRecord::Migration[6.1]
  def db
    ActiveRecord::Base.connection
  end

  def alter_column_to_utf8mb(table, column)
    default = column.default.blank? ? '' : "DEFAULT '#{column.default}'"
    null = column.null ? '' : 'NOT NULL'
    execute "ALTER TABLE `#{table}` MODIFY `#{column.name}` #{column.sql_type.upcase}
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci #{default} #{null};"
  end

  def change
    execute "ALTER DATABASE `#{db.current_database}` CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;"
    db.tables.each do |table|
      execute "ALTER TABLE `#{table}` ROW_FORMAT=DYNAMIC CHARACTER SET
      utf8mb4 COLLATE utf8mb4_unicode_ci;"

      db.columns(table).each do |column|
        case column.sql_type
        when /([a-z]*)text/i
          alter_column_to_utf8mb(table, column)
        when /varchar\(([0-9]+)\)/i
          alter_column_to_utf8mb(table, column)
        end
      end
    end
  end
end
