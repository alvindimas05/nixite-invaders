using System;
using System.Collections;
using System.Collections.Generic;
using Bullet.Damage;
using Unity.VisualScripting;
using UnityEngine;

namespace Bullet
{
    public class BulletSpawner : MonoBehaviour
    {
        public GameObject bullet;
        public float delaySpawn,
            damage;
        private bool _isPlayer;
        private void Awake()
        {
            bullet = Instantiate(bullet);
            bullet.SetActive(false);
            
            _isPlayer = CompareTag("Player");
            bullet.GetComponent<BulletMovement>().fromPlayer = _isPlayer;
            
            var damageScript = bullet.GetComponent<DamageScript>();
            damageScript.damage = damage;
            damageScript.fromPlayer = _isPlayer;
            InvokeRepeating(nameof(SpawnBulletRepeating), 0, delaySpawn);
        }
        private void SpawnBulletRepeating()
        {
            var clone = Instantiate(bullet);
            var pos = transform.position;
            clone.transform.position = new Vector3(pos.x, pos.y, 1);
            clone.SetActive(true);
        }
    }
}