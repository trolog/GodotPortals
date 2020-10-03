using Godot;
using System;

public class Node2D : Godot.Node2D
{

    float target_angle = 0;
    float turn_speed = Mathf.Deg2Rad(3);
    public override void _Process(float delta)
    {
        float dir = GetAngleTo(GetGlobalMousePosition());//GetNode<KinematicBody2D>("/root/main/rat").GetAngleTo(GetGlobalMousePosition());
        GD.Print(dir.ToString());
        GD.Print(Mathf.Abs(dir).ToString() + " Check");
        if(Mathf.Abs(dir) < turn_speed)
        {
            Rotation += dir;
        }
        else
        {
            if(dir > 0) // we're more towards the left so turn right
            {
                Rotation += turn_speed;
            }
            if(dir < 0) // we're more towards the right so turn to the left
            {
                Rotation -= turn_speed;
            }
        }
        var velocity = new Vector2(1, 0).Rotated(Rotation) * 5;
        GlobalPosition += velocity;
    }
}
