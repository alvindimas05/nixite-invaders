using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Character.Player
{
    public class MoveScript : MonoBehaviour
    {
        public float moveSpeed;
        private Rigidbody2D _rb;

        private void Start()
        {
            _rb = GetComponent<Rigidbody2D>();
        }

        private void Update()
        {
            _rb.velocity = new Vector2(Input.GetAxisRaw("Horizontal"), 0) * moveSpeed;
        }
    }
}
