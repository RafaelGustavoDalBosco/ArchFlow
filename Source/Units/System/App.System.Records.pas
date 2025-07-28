unit App.System.Records;

interface

type

   TVersionInformation = record
      Major: Word;
      Minor: Word;
      Release: Word;
      Build: Word;

      /// <summary>
      ///    Major<shl 48> Minor<shl 32> Release<shl 16> Buid<shl 0>
      /// </summary>
      function ToInt64: Int64;
   end;

implementation

{ TVersionInformation }

function TVersionInformation.ToInt64: Int64;
begin
   Result := (Int64(Major) shl 48) or (Int64(Minor) shl 32) or (Int64(Release) shl 16) or Build;
end;

end.
