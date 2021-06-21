port module ManualSlideshow exposing (main)

import Array
import Browser
import Element as E
import Element.Background as Eb
import Element.Events as Ee
import Element.Font as Font
import Element.Input as Ei
import Html
import Html.Attributes as Hat


port pageloaded : (Int -> msg) -> Sub msg


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type Msg
    = LeftButtonClick
    | RightButtonClick
    | OverLeftButton
    | OverRightButton
    | LeaveLeftButton
    | LeaveRightButton
    | PageLoaded Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( { position = 0, over = NotOver, loaded = False }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    E.layout [] <| viewHelp model


images : Array.Array ( String, String )
images =
    Array.fromList
        [ ( "44.jpg", "Arial view of house and surroundings" )
        , ( "45.jpg", "High arial view, including distant sea view" )
        , ( "ranscombe3dView.jpg", "3D view of Ranscombe interior" )
        , ( "27.jpg", "Swings on lawn" )
        , ( "28.jpg", "Picnic by the pond" )
        , ( "29.jpg", "Stove in kitchen and living area" )
        , ( "30.jpg", "Kitchen and living area" )
        , ( "31.jpg", "White flowers in kitchen" )
        , ( "32.jpg", "Breakfast in Ivy bedroom" )
        , ( "33.jpg", "Iris bedroom" )
        , ( "34.jpg", "Upstairs hallway" )
        , ( "35.jpg", "Rose bathroom" )
        , ( "36.jpg", "Rose bedroom" )
        , ( "37.jpg", "Ivy bedroom" )
        , ( "38.jpg", "Ivy bathroom" )
        , ( "39.jpg", "Wisteria bedroom" )
        , ( "40.jpg", "Wisteria bathroom" )
        , ( "41.jpg", "Kitchen and living area" )
        , ( "42.jpg", "Sitting room" )
        , ( "43.jpg", "Kitchen and living area" )
        , ( "085117.jpg", "Cottage living area" )
        , ( "085149.jpg", "Cottage living area" )
        , ( "085451.jpg", "Cottage conservatory" )
        , ( "204133.jpg", "Ranscombe front porch" )
        , ( "18.jpg", "Ornamental parterre in front of the Manor" )
        , ( "10.jpg", "View from Rose bathroom window" )
        , ( "11.jpg", "Sitting room" )
        , ( "12.jpg", "Dining room" )
        , ( "13.jpg", "View from front door" )
        , ( "14.jpg", "Front porch" )
        , ( "15.jpg", "Front of house" )
        , ( "16.jpg", "Builder's engraving on stone" )
        , ( "17.jpg", "Seating area in front of house" )
        , ( "19.jpg", "View of house from behind barns" )
        , ( "20.jpg", "Arial view of house and barns" )
        , ( "21.jpg", "Arial view of house and surroundings" )
        , ( "23.jpg", "View of nearby fields" )
        , ( "24.jpg", "Pink flower on iron railing" )
        , ( "25.jpg", "Pigeon flying from fountain" )
        , ( "26.jpg", "View of pond" )
        , ( "03.jpg", "Fern bedroom" )
        ]


type alias Model =
    { position : Int
    , over : Over
    , loaded : Bool
    }


type Over
    = OverLeft
    | OverRight
    | NotOver


viewHelp : Model -> E.Element Msg
viewHelp model =
    case Array.get model.position images of
        Nothing ->
            E.none

        Just ( root, alt ) ->
            oneSlide model.loaded model.position root alt model.over


oneSlide : Bool -> Int -> String -> String -> Over -> E.Element Msg
oneSlide loaded counter root alt over =
    E.column [E.width E.fill, E.spacing 6] <|
        [ if loaded then
            E.el [ E.width E.fill ] (image root alt)
          else
            E.el [ E.width E.fill ] <|
                case Array.get 1 images of
                    Nothing ->
                        E.none

                    Just (root1, alt1) ->
                        image root1 alt1
            
        , E.row [E.width E.fill, E.spacing 6]
            [ leftButton over
            , rightButton over
            ]
        , if loaded then
            caption alt
          else
            E.el captionStyle (E.text "Loading...")
        , if loaded then
            counterView counter
          else
            E.none
        ]


captionStyle =
    [ Font.family [ Font.typeface "Alegreya" ]
    , Font.size 20
    , E.centerX
    , E.padding 5
    ]


caption alt =
    E.el captionStyle (E.text alt)


counterView counter =
    E.el
        [ E.centerX
        , Font.family [ Font.typeface "Alegreya" ]
        , Font.size 30
        ]
    <|
        E.text <|
            String.fromInt (counter + 1)
                ++ " / "
                ++ String.fromInt (Array.length images)


buttonTextStyle =
    [ Font.size 100
    , Font.color <| E.rgb255 180 180 180
    , E.centerX
    ]


buttonStyle =
    [ noOutline
    , E.width E.fill
    ]


noOutline =
    E.htmlAttribute <| Hat.style "box-shadow" "none"


leftButton over =
    Ei.button
        ([ Ee.onMouseLeave LeaveLeftButton
         , Ee.onMouseEnter OverLeftButton
         , case over of
            OverLeft ->
                Eb.color hover

            _ ->
                Eb.color notHover
         ]
            ++ buttonStyle
        )
        { onPress = Just LeftButtonClick
        , label =
            E.el
                buttonTextStyle
                (E.text "<<")
        }


hover =
    E.rgb255 215 215 215


notHover =
    E.rgb255 230 230 230


rightButton over =
    Ei.button
        ([ Ee.onMouseLeave LeaveLeftButton
         , Ee.onMouseEnter OverRightButton
         , case over of
            OverRight ->
                Eb.color hover

            _ ->
                Eb.color notHover
         ]
            ++ buttonStyle
        )
        { onPress = Just RightButtonClick
        , label =
            E.el
                buttonTextStyle
                (E.text ">>")
        }


image root alt =
    E.image
        [ E.width E.fill
        ]
        { src = "clickslideshow/" ++ root
        , description = alt
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    pageloaded PageLoaded


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LeftButtonClick ->
            if model.loaded then
                ( if model.position == 0 then
                    { model | position = Array.length images - 1 }

                  else
                    { model | position = model.position - 1 }
                , Cmd.none
                )
            else
                (model, Cmd.none)

        RightButtonClick ->
            if model.loaded then
                ( if model.position == Array.length images - 1 then
                    { model | position = 0 }

                  else
                    { model | position = model.position + 1 }
                , Cmd.none
                )
            else
                (model, Cmd.none)

        OverLeftButton ->
            ( { model | over = OverLeft }, Cmd.none )

        OverRightButton ->
            ( { model | over = OverRight }, Cmd.none )

        LeaveLeftButton ->
            ( { model | over = NotOver }, Cmd.none )

        LeaveRightButton ->
            ( { model | over = NotOver }, Cmd.none )

        PageLoaded _ ->
            ( { model | loaded = True } , Cmd.none )
