using Character;
using UnityEngine;

namespace Bullet.Damage
{
    public class DamageScript : MonoBehaviour
    {
        public float damage;
        public bool fromPlayer;
        private void SendDamage(GameObject enemyObject)
        {
            var character = enemyObject.GetComponent<CharacterScript>();
            character.healthPoints -= damage;
            character.DamageEffect.StartEffect();
        }
        private void OnTriggerEnter2D(Collider2D other)
        {
            if ((other.CompareTag("Player") && !fromPlayer) ||
                (other.CompareTag("Enemy") && fromPlayer)) SendDamage(other.gameObject);   
        }
    }
}