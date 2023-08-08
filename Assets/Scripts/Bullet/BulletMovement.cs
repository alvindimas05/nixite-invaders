using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

namespace Bullet
{
    public class BulletMovement : MonoBehaviour
    {
        public float limitY,
            moveSpeed;
        public bool fromPlayer;
        private Rigidbody2D _rb;
        void Start()
        {
            _rb = GetComponent<Rigidbody2D>();
            if (!fromPlayer)
            {
                limitY *= -1;
                moveSpeed *= -1;
            }
        }
        void Update()
        {
            _rb.velocity = new Vector2(0, moveSpeed);
            if(Math.Abs(transform.position.y) >= Math.Abs(limitY)) Destroy(gameObject);
        }
    }

}