--  SPDX-License-Identifier: Apache-2.0
--
--  Copyright (c) 2021 onox <denkpadje@gmail.com>
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

package body Emojis is

   package UTF renames Ada.Strings.UTF_Encoding;

   function Unicode (Number : Long_Integer) return UTF.UTF_8_String is
     (UTF.Wide_Wide_Strings.Encode ("" & Wide_Wide_Character'Val (Number)));

   function Unicode (Number_1, Number_2 : Long_Integer) return UTF.UTF_8_String is
     (UTF.Wide_Wide_Strings.Encode
        (Wide_Wide_Character'Val (Number_1) &
         Wide_Wide_Character'Val (Number_2)));

   function Unicode (Number_1, Number_2, Number_3 : Long_Integer) return UTF.UTF_8_String is
     (UTF.Wide_Wide_Strings.Encode
        (Wide_Wide_Character'Val (Number_1) &
         Wide_Wide_Character'Val (Number_2) &
         Wide_Wide_Character'Val (Number_3)));

   use type SU.Unbounded_String;

   function Labels return String_List is
      Result : String_List
        (1 .. Name_Emojis_1'Length + Name_Emojis_2'Length + Name_Emojis_3'Length);
      Index  : Positive := Result'First;
   begin
      for Pair of Name_Emojis_1 loop
         Result (Index) := Pair.Text;
         Index := Index + 1;
      end loop;

      for Pair of Name_Emojis_2 loop
         Result (Index) := Pair.Text;
         Index := Index + 1;
      end loop;

      for Pair of Name_Emojis_3 loop
         Result (Index) := Pair.Text;
         Index := Index + 1;
      end loop;

      return Result;
   end Labels;

   function Value (Label : String) return String is
   begin
      for Pair of Name_Emojis_3 loop
         if Pair.Text = Label then
            return Unicode (Pair.Point_1, Pair.Point_2, Pair.Point_3);
         end if;
      end loop;

      for Pair of Name_Emojis_2 loop
         if Pair.Text = Label then
            return Unicode (Pair.Point_1, Pair.Point_2) & " ";
         end if;
      end loop;

      for Pair of Name_Emojis_1 loop
         if Pair.Text = Label then
            return Unicode (Pair.Point_1);
         end if;
      end loop;

      return "";
   end Value;

   function Replace_Labels (Text : String) return String is
      Text_List : constant String_List := Strings.Split (Text, Separator => ":");
      Result    : SU.Unbounded_String;
   begin
      for Index in Text_List'Range loop
         if Index mod 2 = 0 then
            declare
               Slice : constant String := +Text_List (Index);
               Emoji : constant String := (if Index < Text_List'Last then Value (Slice) else "");
            begin
               if Emoji /= "" then
                  SU.Append (Result, Emoji);
               else
                  if Index = Text_List'Last then
                     SU.Append (Result, ":" & Slice);
                  else
                     SU.Append (Result, ":" & Slice & ":");
                  end if;
               end if;
            end;
         else
            SU.Append (Result, Text_List (Index));
         end if;
      end loop;

      return +Result;
   end Replace_Labels;

   function Replace_Mappings
     (Text        : String;
      Mappings    : Label_Mappings;
      Completions : Completion_Mappings) return String
   is
      Slices : String_List := Strings.Split (Text, Separator => " ");

      Is_Space : constant Boolean := Slices (Slices'Last) = "";
   begin
      for Index in Slices'Range loop
         declare
            Is_Completion : constant Boolean := Index = Slices'Last - 1 and Is_Space;
         begin
            for Pair of Mappings loop
               if not (for some C of Completions => C = Pair.Text)
                 or (Index < Slices'Last and not Is_Completion)
               then
                  if Slices (Index) = Pair.Text then
                     Slices (Index) := ":" & Pair.Label & ":";
                  end if;
               end if;
            end loop;
         end;
      end loop;

      return Strings.Join (Slices, " ");
   end Replace_Mappings;

   function Replace
     (Text        : String;
      Mappings    : Label_Mappings      := Text_Emojis;
      Completions : Completion_Mappings := (1 .. 0 => <>)) return String is
   begin
      return Replace_Labels (Replace_Mappings (Text, Mappings, Completions));
   end Replace;

end Emojis;
