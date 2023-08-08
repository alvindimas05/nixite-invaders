using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Bullet.Damage
{
    public class DamageEffect
    {
        private readonly MonoBehaviour _obj;
        private readonly SpriteRenderer _sprite;
        private readonly Color _baseColor = new(0, 0, 0, 1);
        private readonly float _delay;
        private readonly int _repeat;
        private IEnumerator _effectEnumerator;
        private bool _isRunning;
        public DamageEffect(MonoBehaviour obj, GameObject character, float delay, int repeat)
        {
            _obj = obj;
            _sprite = character.GetComponent<SpriteRenderer>();
            _delay = delay;
            _repeat = repeat;
        }
        public void StartEffect()
        {
            if (_isRunning) return;

            _isRunning = true;
            _effectEnumerator = EffectEnumerator();
            _obj.StartCoroutine(_effectEnumerator);
        }
        private IEnumerator EffectEnumerator()
        {
            for (int i = 0; i < _repeat; i++)
            {
                _sprite.color -= _baseColor;
                yield return new WaitForSeconds(_delay);
                _sprite.color += _baseColor;
                yield return new WaitForSeconds(_delay);
            }
            _isRunning = false;
        }
    }
}