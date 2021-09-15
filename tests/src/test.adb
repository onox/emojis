with Ada.Text_IO;
with Ada.Strings.Fixed;

with Emojis;

procedure Test is
   use Emojis;
   use Ada.Text_IO;

   package SF renames Ada.Strings.Fixed;
begin
   Put_Line ("Text emojis:");
   for Pair of Emojis.Text_Emojis loop
      Put_Line
        (SF.Tail (+Pair.Text, 3) & " = " & Emojis.Replace (":" & (+Pair.Label) & ":"));
   end loop;

   Put_Line ("");
   Put_Line ("Labels and text emojis:");
   Put_Line ("'" & Emojis.Replace
     ("Ada is :heart_eyes: :sparkles:" & ", " &
      "Rust is :crab::church::rocket::military_helmet:" & ", " &
      "C++ is :woozy_face:" & ", " &
      "C is :boom:" & ", " &
      "Perl is XO= :p") & "'");

   Put_Line ("");
   Put_Line ("Input completions:");
   Put_Line ("'" & Emojis.Replace
     ("XD :o :p", Completions => Emojis.Lower_Case_Text_Emojis) & "'");

   Put_Line ("");
   Put_Line ("1 codepoint:");
   Put_Line ("'" & Emojis.Replace (":foot: :sparkles: :face_with_monocle:") & "'");
   Put_Line ("'" & Emojis.Replace
     (":bagel: :duck: :dango: :bacon: :crab: :sushi: :fried_shrimp:") & "'");
   Put_Line ("'" & Emojis.Replace
     (":fish_cake: :owl: :tumbler_glass: :unicorn_face: :pancakes:") & "'");
   Put_Line ("'" & Emojis.Replace
     (":lollipop: :mate_drink: :waffle: :ice_cube: :sandwich:") & "'");
   Put_Line ("'" & Emojis.Replace (":telescope: :checkered_flag: :yum:") & "'");

   Put_Line ("");
   Put_Line ("2 codepoints:");
   Put_Line ("'" & Emojis.Replace (":radioactive_sign: :alembic:") & "'");
   Put_Line ("'" & Emojis.Replace
     (":desktop_computer: :joystick: :ballot_box_with_ballot: :shield:") & "'");

   Put_Line ("");
   Put_Line ("3 codepoints:");
   Put_Line ("'" &
     Emojis.Replace (":female-scientist: :face_with_spiral_eyes: :male-astronaut:") & "'");
end Test;
