using System;
using Bullet.Damage;
using UnityEngine;

namespace Character
{
    public class CharacterScript : MonoBehaviour
    {
        public float healthPoints;
        public float damageEffectDelay;
        public int damageEffectRepeat;
        public DamageEffect DamageEffect;

        private void Awake()
        {
            DamageEffect = new DamageEffect(this, gameObject, damageEffectDelay, damageEffectRepeat);
        }
    }
}