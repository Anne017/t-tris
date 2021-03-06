import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Particles 2.0

 Item {
     id: block
     property int type
     property string cellColor: "red"
     property bool dying: false
     property bool spawned: false


     Image {
         id: img
         anchors.fill: parent
         source: "/assets/" + cellColor +"Stone.png"
         opacity: 0.5
     }

     ParticleSystem{
         id:particleSystem


         ImageParticle {
             width: 1; height: 1
             anchors.centerIn: parent
             source: "/assets/redStar.png";

         }

         Emitter{
             id: particles
             anchors.centerIn: parent
             emitRate: 0
             lifeSpan: 700
             velocity: AngleDirection {angleVariation: 360; magnitude: 80; magnitudeVariation: 40}
             size: 16
         }
     }

     states: [
         State {
             name: "AliveState"; when: spawned == true && dying == false
             PropertyChanges { target: img; opacity: 1 }
         },

         State {
             name: "DeathState"; when: dying == true
             StateChangeScript { script: particles.burst(20); }
             PropertyChanges { target: img; opacity: 0 }
             StateChangeScript { script: block.destroy(1000); }
         }
     ]
 }

//Rectangle {
//    id: block
//    property int type
//    color: "gray"
//    border.width: 1
//}
