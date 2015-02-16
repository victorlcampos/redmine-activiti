# Redmine - project management software
# Copyright (C) 2006-2014  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

module RedmineActiviti
  module Patches

    module Customizable
      def self.included(base)
        base.after_initialize :add_custom_fields_methods
      end

      def add_custom_fields_methods
        available_custom_fields.each do |cf|
          next if cf.method_name.blank? || respond_to?(cf.method_name)

          self.class.send(:define_method, cf.method_name) do
            custom_field_value(cf)
          end

          self.class.send(:define_method, "#{cf.method_name}=") do |value|
            self.custom_field_values = {cf.id => value}
          end
        end
      end
    end
  end
end
