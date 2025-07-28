unit App.System.List;

interface

uses
   System.SysUtils, System.Generics.Collections;

type

   TSystemList = class sealed (TObjectList<TObject>)
   public
      /// <summary>
      ///   Remove todos os itens da lista
      /// </summary>
      procedure RemoveAllItems;

      /// <summary>
      ///    Adiciona um objeto a lista, e retorna o mesmo
      /// </summary>
      /// <param name="AClass">
      ///    Define qual é a classe do objeto que será incluída na listagem
      /// </param>
      function AddInstanceOf(const AClass: TClass): TObject;

      constructor Create; overload;
   end;

implementation

{ TSystemList }

function TSystemList.AddInstanceOf(const AClass: TClass): TObject;
begin
   Result := AClass.NewInstance;
   inherited Add(Result);
end;

constructor TSystemList.Create;
begin
   inherited Create(True);
end;

procedure TSystemList.RemoveAllItems;
var
   LLoop: Integer;
begin
   for LLoop := Count - 1 downto 0 do
      Delete(LLoop);
end;

end.
